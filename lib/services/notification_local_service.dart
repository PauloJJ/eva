import 'package:app_settings/app_settings.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationLocalService extends GetxController {
  Rx<FlutterLocalNotificationsPlugin?> flutterLocalNotificationsPlugin = Rx(
    null,
  );

  @override
  void onInit() {
    initNotification();
    super.onInit();
  }

  initNotification() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_laucher');

    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    flutterLocalNotificationsPlugin.value = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.value!.initialize(
      settings: initSettings,
    );
  }

  Future<bool> requestPermission() async {
    final status = await Permission.notification.request();

    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      FeedbackComponent.showConfirmAction(
        information:
            '🔔 A Eva precisa da sua permissão para enviar lembretes. Ative as notificações nas configurações do seu celular para receber avisos importantes no momento certo.',
        function: () {
          AppSettings.openAppSettings(type: AppSettingsType.notification);
          Get.back();
        },
      );

      return false;
    }

    return true;
  }

  showNotification({
    required String title,
    required String body,
    required String? payload,
  }) async {
    if (await requestPermission() == false) {
      return;
    }

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        '01',
        'general_notifications',
        channelDescription: 'General notification channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    flutterLocalNotificationsPlugin.value!.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }

  Future<void> schedulePeriodicNotifications({
    required String title,
    required String? body,
    required int id,
    required tz.TZDateTime scheduleDate,
    required String payload,
  }) async {
    await flutterLocalNotificationsPlugin.value!.zonedSchedule(
      id: id,
      scheduledDate: scheduleDate,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_schedule_date',
          'channel_schedule_date',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      title: title,
      body: body,
      payload: payload,
    );

    print(
      '========== NOTIFICAÇÃO CADASTRADA DIARIAMENTE: $scheduleDate ---- ID: $id ----- $title PAYLOAD: $payload ==========',
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.value!.cancelAll();
    print(
      '========== CENCELAR TODAS AS NOTIFICAÇÕES ==========',
    );
  }

  Future<void> cancelNotifications(int notificationId) async {
    await flutterLocalNotificationsPlugin.value!.cancel(id: notificationId);
    print(
      '========== CENCELANDO NOTIFICAÇÃO TAREFA CONCLUIDA ==========',
    );
  }
}
