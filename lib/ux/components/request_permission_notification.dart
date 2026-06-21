import 'package:app_settings/app_settings.dart'
    show AppSettings, AppSettingsType;
import 'package:eva/services/notification_local_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionNotification extends StatelessWidget {
  RequestPermissionNotification({super.key});

  final NotificationLocalService notificationLocalService =
      Get.find<NotificationLocalService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notification_important,
              size: 150,
              color: color.primary,
            ),

            SizedBox(height: 20),

            Text(
              'Permitir notificação',
              style: AppTextStyleTheme.h1,
            ),

            SizedBox(height: 5),

            Text(
              'Precisamos da sua permissão para enviar notificações e garantir o funcionamento correto desta funcionalidade. ✅',
              textAlign: TextAlign.center,
              style: AppTextStyleTheme.subTitle,
            ),

            SizedBox(height: 20),

            ButtonsComponent.buttonFilled(
              title: 'Permitir notificações',
              function: () async {
                await notificationLocalService.initNotification();

                notificationLocalService.permissionNotification.value =
                    await Permission.notification.request();

                final permissionNotification =
                    notificationLocalService.permissionNotification.value!;

                if (permissionNotification.isDenied ||
                    permissionNotification.isPermanentlyDenied ||
                    permissionNotification.isRestricted) {
                  AppSettings.openAppSettings(
                    type: AppSettingsType.notification,
                  );
                }
              },
            ),

            SizedBox(height: 5),

            TextButton.icon(
              onPressed: () async {
                notificationLocalService.permissionNotification.value =
                    await Permission.notification.request();

                print(notificationLocalService.permissionNotification.value);

                final permissionNotification =
                    notificationLocalService.permissionNotification.value!;

                if (permissionNotification.isDenied ||
                    permissionNotification.isPermanentlyDenied ||
                    permissionNotification.isRestricted) {
                  FeedbackComponent.definitiveError(
                    message: 'Permissão de notificações não concedida.',
                  );
                }
              },
              icon: Icon(Icons.refresh),
              label: Text(
                'Verificar permissão',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
