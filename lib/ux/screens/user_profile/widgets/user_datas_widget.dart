import 'package:eva/models/user_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDatasWidget extends StatelessWidget {
  UserDatasWidget({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    UserModel userModel = userService.userModel.value!;

    return Container(
      decoration: BoxDecoration(
        color: color.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.person_outline_rounded,
              size: 30,
              color: color.primary,
            ),
            title: Text(userModel.name),
          ),

          Divider(
            height: 10,
          ),

          ListTile(
            leading: Icon(
              Icons.email_outlined,
              size: 30,
              color: color.primary,
            ),
            title: Text(userModel.email),
          ),

          Divider(
            height: 10,
          ),

          ListTile(
            leading: Icon(
              Icons.phone_enabled_outlined,
              size: 30,
              color: color.primary,
            ),
            title: Text(userModel.phoneNumber),
          ),

          Divider(
            height: 10,
          ),

          ListTile(
            leading: Icon(
              Icons.description_outlined,
              size: 30,
              color: color.primary,
            ),
            title: Text(userModel.cpf),
          ),

          SizedBox(height: 5),
        ],
      ),
    );
  }
}
