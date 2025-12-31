import 'package:eva/firebase_options.dart';
import 'package:eva/services/actions_service.dart';
import 'package:eva/services/animations_controller_service.dart';
import 'package:eva/services/auth_app_service.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/instance_manager.dart';

class InjectDependency {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await dotenv.load(fileName: '.env');

    Get.put(HiveService());
    Get.put(AuthAppService());
    Get.put(UserService());
    Get.put(AnimationsControllerService());
    Get.put(ActionsService());
  }
}
