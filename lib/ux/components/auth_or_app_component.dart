import 'package:eva/models/user_model.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/ux/components/bottom_navigation_component.dart';
import 'package:eva/ux/screens/loadings/loadings_screen.dart';
import 'package:eva/ux/screens/login/login_screen.dart';
import 'package:eva/ux/screens/tutorial/tutorial_screen.dart';
import 'package:eva/ux/screens/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthOrAppComponent extends StatelessWidget {
  AuthOrAppComponent({super.key});

  final HiveService hiveService = Get.find();
  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool? firstTimeOnTheApp = hiveService.firstTimeOnTheApp.value;

      return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(
              () {
                UserModel? userModel = userService.userModel.value;

                if (userModel == null) {
                  return LoadingsScreen();
                } else {
                  if (userModel.didTheTutorial == false) {
                    return TutorialScreen();
                  } else {
                    return BottomNavigationComponent();
                  }
                }
              },
            );
          } else {
            if (firstTimeOnTheApp == null) {
              return LoadingsScreen();
            } else {
              if (firstTimeOnTheApp == false) {
                return LoginScreen();
              } else {
                return WelcomeScreen();
              }
            }
          }
        },
      );
    });
  }
}
