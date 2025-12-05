import 'package:eva/firebase_options.dart';
import 'package:eva/services/auth_app_service.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class InjectDependency {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Get.put(HiveService());
    Get.put(AuthAppService());
    Get.put(UserService());
  }
}
