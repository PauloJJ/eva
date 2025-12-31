import 'package:eva/models/personal_network_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowListPersonalNetworkComponent {
  static Future<PersonalNetworkModel?> showList() async {
    UserService userService = Get.find();

    List<PersonalNetworkModel> listPersonalNetworkModel =
        userService.listPersonalNetworkModel.value;

    PersonalNetworkModel? personalNetworkModelSelect;

    await showDialog(
      context: Get.context!,
      fullscreenDialog: true,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(20),
        title: Text('Selecione uma pessoa'),
        content: SizedBox(
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                itemCount: listPersonalNetworkModel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  PersonalNetworkModel personalNetworkModel =
                      listPersonalNetworkModel[index];

                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CircleAvatar(
                          radius: 27,
                          backgroundImage: personalNetworkModel.image == null
                              ? null
                              : NetworkImage(
                                  personalNetworkModel.image!,
                                ),
                          child: personalNetworkModel.image == null
                              ? Text(
                                  personalNetworkModel.name[0],
                                  style: AppTextStyleTheme.h3,
                                )
                              : null,
                        ),
                        title: Text(
                          personalNetworkModel.name,
                          style: AppTextStyleTheme.title,
                        ),
                        onTap: () {
                          personalNetworkModelSelect = personalNetworkModel;

                          Get.back();
                        },
                      ),

                      Divider(height: 40),
                    ],
                  );
                },
              ),

              ButtonsComponent.buttonFilled(
                title: 'Voltar',
                function: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );

    return personalNetworkModelSelect;
  }
}
