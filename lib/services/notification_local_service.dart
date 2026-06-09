import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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
        'channelId',
        'daily_notifications',
        channelDescription: 'General notification channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    flutterLocalNotificationsPlugin.value!.show(
      id: 0,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}
