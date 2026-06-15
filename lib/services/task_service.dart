import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/payload_notification_model.dart';
import 'package:eva/models/task_model.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/services/notification_local_service.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/components/show_loading_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class TaskService {
  Rx<DateTime> dateSelect = Rx(DateTime.now());
  Rx<List<TaskModel>> listTasks = Rx([]);

  // Modelo: 15/09/2025
  Rx<List<String>> tasksCompleted = Rx([]);

  taskCompletedOrRemove(TaskModel taskModel) {
    HiveService hiveService = Get.find<HiveService>();

    String dateNow = DateFormat(
      'dd/MM/yyyy',
    ).format(tz.TZDateTime.now(tz.local));

    String date = DateFormat('dd/MM/yyyy').format(dateSelect.value);

    if (dateNow != date) {
      FeedbackComponent.definitiveError(
        message: 'Tarefas só podem ser concluídas na data atual',
      );

      return;
    }

    date = '${date}_${taskModel.docId}';

    if (!tasksCompleted.value.contains(date)) {
      tasksCompleted.value.add(date);
    }

    cancelNotification(taskModel);

    tasksCompleted.update((val) {});
    hiveService.updateListTasks(tasksCompleted.value);
  }

  cancelNotification(TaskModel taskModel) async {
    NotificationLocalService notificationLocalService =
        Get.find<NotificationLocalService>();

    List<PendingNotificationRequest> listNotifications =
        await notificationLocalService.flutterLocalNotificationsPlugin.value!
            .pendingNotificationRequests();

    String date =
        '${dateSelect.value.day}/${dateSelect.value.month}/${dateSelect.value.year}';

    for (var notification in listNotifications) {
      Map<String, dynamic> payloadTask = await jsonDecode(
        notification.payload!,
      );

      PayloadNotificationModel payloadNotificationModel =
          PayloadNotificationModel.fromJson(payloadTask);

      if (date == payloadNotificationModel.date &&
          payloadNotificationModel.taskId == taskModel.taskId) {
        notificationLocalService.cancelNotifications(notification.id);
      }
    }
  }

  Stream<List<TaskModel>> streamTasks(String userId) async* {
    final snapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .snapshots();

    await for (var e in snapshot) {
      List<TaskModel> list = e.docs.map(
        (e) {
          TaskModel taskModel = TaskModel.fromJson(e.data());
          taskModel.docId = e.id;

          return taskModel;
        },
      ).toList();

      yield list;
    }
  }

  String formatDateAndDocId(String docId) {
    String date = DateFormat('dd/MM/yyyy').format(dateSelect.value);
    date = '${date}_$docId';

    return date;
  }

  Future<void> deleteTask(TaskModel taskModel) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    showLoadingComponent();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskModel.docId)
          .delete();

      await deleteNotification(taskModel);
      await registerNotifications();
    } catch (_) {
      FeedbackComponent.definitiveError(
        message: 'Algo deu errado. Tente novamente.',
      );
    } finally {
      Navigator.of(Get.context!).pop();
    }
  }

  deleteNotification(TaskModel taskModel) async {
    NotificationLocalService notificationLocalService =
        Get.find<NotificationLocalService>();

    List<PendingNotificationRequest> listNotifications =
        await notificationLocalService.flutterLocalNotificationsPlugin.value!
            .pendingNotificationRequests();

    for (var e in listNotifications) {
      Map<String, dynamic> payload = await jsonDecode(e.payload!);

      String taskId = payload['taskId'].toString();

      if (taskId == taskModel.taskId.toString()) {
        notificationLocalService.cancelNotifications(e.id);
      }
    }
  }

  Future<void> registerNotifications() async {
    if (listTasks.value.isEmpty) {
      return;
    }

    final NotificationLocalService notificationLocalService =
        Get.find<NotificationLocalService>();

    await notificationLocalService.cancelAllNotifications();

    List<NotificationModel> listNotifications =
        generatingDatesWithRnadomTimesFiveTimesDay();

    // Criando notificação eleatoria ( sem horario especifcio )
    await createNotification(listNotifications);

    print(
      '=============== AGENDADO NOTIFICAÇÕES PRECISA COM HORARIOS ===============',
    );

    // Geração de notificação em horario especificos
    List<NotificationModel> listNotificationsTimeSpecific =
        generateNotificationsByDateAndTime();

    await createNotification(listNotificationsTimeSpecific);
  }

  createNotification(List<NotificationModel> listNotifications) async {
    final NotificationLocalService notificationLocalService =
        Get.find<NotificationLocalService>();

    for (var notification in listNotifications) {
      bool isRegister = true;

      String date = DateFormat('dd/MM/yyyy').format(notification.dateTime);

      PayloadNotificationModel
      payloadNotificationModel = PayloadNotificationModel(
        date:
            '${notification.dateTime.day}/${notification.dateTime.month}/${notification.dateTime.year}',
        taskId: notification.taskModel.taskId.toString(),
      );

      Map<String, dynamic> map = payloadNotificationModel.toJson();

      for (var e in tasksCompleted.value) {
        String taskCompleted = e.replaceRange(10, null, '');
        String taskId = e.replaceRange(0, 11, '');

        if (taskCompleted == date && taskId == notification.taskModel.docId!) {
          isRegister = false;
        }
      }

      if (isRegister == false) {
        continue;
      }

      String payload = jsonEncode(map);

      await notificationLocalService.schedulePeriodicNotifications(
        title:
            '${notification.taskModel.emoji} ${notification.taskModel.nameTask}',
        body: 'Você possui uma tarefa pendente. ⏳',
        id: Random().nextInt(100000),
        scheduleDate: notification.dateTime,
        payload: payload,
      );
    }
  }

  List<NotificationModel> generateNotificationsByDateAndTime() {
    tz.TZDateTime dateNow = tz.TZDateTime.now(tz.local);

    List<TaskModel> tasks = listTasks.value;

    List<TaskModel> tasksSpecificTime = [];

    List<tz.TZDateTime> listDatesFuture7Days = getDatesFuture7Days();

    for (var e in tasks) {
      if (e.schedules != null) {
        tasksSpecificTime.add(e);
      }
    }

    List<NotificationModel> listNotifications = [];

    for (var task in tasksSpecificTime) {
      final List<int> listWeekDay = getListWeekDay(task);

      for (var dateFuture in listDatesFuture7Days) {
        if (listWeekDay.contains(dateFuture.weekday)) {
          final tz.TZDateTime date = tz.TZDateTime(
            tz.local,
            dateFuture.year,
            dateFuture.month,
            dateFuture.day,
            task.schedules!.hour,
            task.schedules!.minute,
          );

          if (dateNow.compareTo(date) < 0) {
            listNotifications.add(
              NotificationModel(dateTime: date, taskModel: task),
            );
          }
        }
      }
    }

    return listNotifications;
  }

  List<NotificationModel> generatingDatesWithRnadomTimesFiveTimesDay() {
    List<TaskModel> tasks = listTasks.value;

    List<tz.TZDateTime> list30DaysFuture = getDatesFuture30Days();

    List<NotificationModel> newList = [];

    final dateNow = tz.TZDateTime.now(tz.local);

    final dateNowFormated = tz.TZDateTime(
      tz.local,
      dateNow.year,
      dateNow.month,
      dateNow.day,
    );

    for (var e in list30DaysFuture) {
      final dateFormated = tz.TZDateTime(e.location, e.year, e.month, e.day);

      /* Gerando notificações no dia especifico do usuario 
      ( ele pega o horario a cima dele, exemplo: é 15:00, então ele começa gerar a partir de 15:00, podendo ser 15:30, 17:00 .... 5 vezes)  
      OBS: se a tarefa tiver schedules != null -> ele vai pegar o horario e minutos que usuario quer para agendar
      */
      if (dateNowFormated.year == dateFormated.year &&
          dateNowFormated.month == dateFormated.month &&
          dateNowFormated.day == dateFormated.day) {
        int calcHour = 23 - dateNow.hour;
        int calcMinutes = 60 - dateNow.minute;

        for (int i = 0; i < 5; i++) {
          int randomTask = Random().nextInt(listTasks.value.length);

          if (tasks[randomTask].schedules != null) {
            continue;
          }

          int hours = Random().nextInt(calcHour) + dateNow.hour;
          int minutes = Random().nextInt(calcMinutes) + dateNow.minute;

          final newDate = tz.TZDateTime(
            tz.local,
            e.year,
            e.month,
            e.day,
            hours,
            minutes,
          );

          /* Se a terefa atual, não rodar no dia especifico da semana, exemplo: tarefa deve roda toda terça e quarte, 
          mas date dos 30 dias é segunda, então ela vai pegar outra tarefa para criar notificação 
          */
          List<int> listWeekDayTask = getListWeekDay(
            listTasks.value[randomTask],
          );

          if (!listWeekDayTask.contains(newDate.weekday)) {
            randomTask = takeOnAnotherTask(
              listWeekDayTask: listWeekDayTask,
              date: newDate,
              randomTask: randomTask,
            );
          }

          newList.add(
            NotificationModel(dateTime: newDate, taskModel: tasks[randomTask]),
          );
        }
      } else {
        for (int i = 0; i < 5; i++) {
          int randomTask = Random().nextInt(listTasks.value.length);

          if (tasks[randomTask].schedules != null) {
            continue;
          }

          int hours = Random().nextInt(23);
          int minutes = Random().nextInt(60);

          final newDate = tz.TZDateTime(
            tz.local,
            e.year,
            e.month,
            e.day,
            hours,
            minutes,
          );

          /* Se a terefa atual, não rodar no dia especifico da semana, exemplo: tarefa deve roda toda terça e quarte, 
          mas date dos 30 dias é segunda, então ela vai pegar outra tarefa para criar notificação 
          */
          List<int> listWeekDayTask = getListWeekDay(
            listTasks.value[randomTask],
          );

          if (!listWeekDayTask.contains(newDate.weekday)) {
            randomTask = takeOnAnotherTask(
              listWeekDayTask: listWeekDayTask,
              date: newDate,
              randomTask: randomTask,
            );
          }

          newList.add(
            NotificationModel(dateTime: newDate, taskModel: tasks[randomTask]),
          );
        }
      }
    }

    return newList;
  }

  List<tz.TZDateTime> getDatesFuture30Days() {
    tz.TZDateTime dateNow = tz.TZDateTime.now(tz.local);

    List<tz.TZDateTime> list30DaysFuture = [];

    for (int i = 0; i < 30; i++) {
      list30DaysFuture.add(dateNow);
      dateNow = dateNow.add(Duration(days: 1));
    }

    return list30DaysFuture;
  }

  List<tz.TZDateTime> getDatesFuture7Days() {
    tz.TZDateTime dateNow = tz.TZDateTime.now(tz.local);

    List<tz.TZDateTime> list7DaysFuture = [];

    for (int i = 0; i < 7; i++) {
      list7DaysFuture.add(dateNow);
      dateNow = dateNow.add(Duration(days: 1));
    }

    return list7DaysFuture;
  }

  List<int> getListWeekDay(TaskModel taskModel) {
    List<int> listWeekDay = [];

    for (var e in taskModel.repeat) {
      switch (e) {
        case 'Segunda':
          listWeekDay.add(1);
          break;
        case 'Terça':
          listWeekDay.add(2);
          break;
        case 'Quarta':
          listWeekDay.add(3);
          break;
        case 'Quinta':
          listWeekDay.add(4);
          break;
        case 'Sexta':
          listWeekDay.add(5);
          break;
        case 'Sábado':
          listWeekDay.add(6);
          break;
        case 'Domingo':
          listWeekDay.add(7);
          break;
      }
    }

    return listWeekDay;
  }

  int takeOnAnotherTask({
    required List<int> listWeekDayTask,
    required tz.TZDateTime date,
    required int randomTask,
  }) {
    List<TaskModel> tasks = listTasks.value;
    int? newIndex;

    if (!listWeekDayTask.contains(date.weekday)) {
      for (int index = 0; index < listTasks.value.length; index++) {
        if (tasks[randomTask].schedules != null) {
          continue;
        }

        TaskModel taskModel = listTasks.value[index];

        List<int> list = getListWeekDay(taskModel);

        if (list.contains(date.weekday)) {
          newIndex = index;
        }
      }
    }

    return newIndex!;
  }
}

class NotificationModel {
  late tz.TZDateTime dateTime;
  late TaskModel taskModel;

  NotificationModel({required this.dateTime, required this.taskModel});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    taskModel = json['taskModel'];
  }
}
