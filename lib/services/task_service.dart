import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/task_model.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';

class TaskService {
  Rx<DateTime> dateSelect = Rx(DateTime.now());

  Rx<List<TaskModel>> listTasks = Rx([]);

  // Modelo: 15/09/2025
  Rx<List<String>> tasksCompleted = Rx([]);

  taskCompletedOrRemove(String docId) {
    HiveService hiveService = Get.find<HiveService>();

    String date = DateFormat('dd/MM/yyyy').format(dateSelect.value);

    date = '${date}_$docId';

    if (tasksCompleted.value.contains(date)) {
      tasksCompleted.value.remove(date);
    } else {
      tasksCompleted.value.add(date);
    }

    tasksCompleted.update((val) {});
    hiveService.updateListTasks(tasksCompleted.value);
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

  Future<void> deleteTask(String docId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(docId)
          .delete();

      FeedbackComponent.successfulAction(message: 'Sua tarefa foi excluída.');
    } catch (_) {
      FeedbackComponent.definitiveError(
        message: 'Algo deu errado. Tente novamente.',
      );
    }
  }
}
