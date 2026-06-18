import 'package:eva/firebase_options.dart';
import 'package:eva/services/actions_service.dart';
import 'package:eva/services/animations_controller_service.dart';
import 'package:eva/services/auth_app_service.dart';
import 'package:eva/services/get_review_user_service.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/services/task_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class InjectDependency {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    tz.initializeTimeZones();

    final TimezoneInfo currentTimeZone =
        await FlutterTimezone.getLocalTimezone();

    String identifier = currentTimeZone.identifier == 'GMT'
        ? 'America/Sao_Paulo'
        : currentTimeZone.identifier;

    final location = tz.getLocation(identifier);
    tz.setLocalLocation(location);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Get.put(AuthAppService());
    Get.put(UserService());
    Get.put(TaskService());

    final HiveService hiveService = Get.put(HiveService());
    await hiveService.initHive();

    Get.put(AnimationsControllerService());
    Get.put(ActionsService());

    GetReviewUserService.getAvaluation();
  }
}
