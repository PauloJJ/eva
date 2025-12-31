import 'package:eva/models/user_model.dart';
import 'package:eva/services/fairy_godmonthers_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListFairyGodmonthersWidget extends StatelessWidget {
  ListFairyGodmonthersWidget({super.key});

  final FairyGodmonthersService fairyGodmonthersService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount:
                fairyGodmonthersService.listFairyGodmonthers.value.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              UserModel userModel =
                  fairyGodmonthersService.listFairyGodmonthers.value[index];

              return ListTile(
                onTap: () {
                  fairyGodmonthersService.showDatasUser(userModel);
                },
                contentPadding: EdgeInsets.all(0),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userModel.profileImage),
                ),
                title: Text(
                  userModel.name,
                  style: AppTextStyleTheme.title,
                ),
                subtitle: Text(userModel.professionFairyGodmonther!),

                trailing: Icon(Icons.arrow_forward_rounded),
              );
            },
          ),
        );
      },
    );
  }
}
