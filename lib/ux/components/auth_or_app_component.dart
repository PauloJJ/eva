import 'package:eva/services/hive_service.dart';
import 'package:eva/ux/screens/login/login_screen.dart';
import 'package:eva/ux/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthOrAppComponent extends StatelessWidget {
  AuthOrAppComponent({super.key});

  final HiveService hiveService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool firstTimeOnTheApp = hiveService.firstTimeOnTheApp.value;

      if (firstTimeOnTheApp == true) {
        return LoginScreen();
      } else {
        return WelcomeScreen();
      }
    });
  }
}
