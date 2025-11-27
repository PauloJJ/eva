import 'package:eva/firebase_options.dart';
import 'package:eva/services/auth_app_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';

class InjectDependency {
  static init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Get.put(AuthAppService());
  }
}
