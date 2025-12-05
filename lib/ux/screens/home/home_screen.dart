import 'package:eva/services/user_service.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userService.userModel.value == null
                      ? ''
                      : userService.userModel.value!.name,
                ),

                ButtonsComponent.buttonFilled(
                  title: 'ola',
                  function: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
