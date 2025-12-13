import 'package:eva/services/user_service.dart';
import 'package:eva/ux/screens/get_localization/get_localization_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class Stage04Widget extends StatelessWidget {
  Stage04Widget({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetLocalizationScreen();
  }
}
