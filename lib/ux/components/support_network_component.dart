import 'package:eva/models/personal_network_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/format_text_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportNetworkComponent extends StatelessWidget {
  SupportNetworkComponent({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<PersonalNetworkModel> listPersonalNetworkModel =
            userService.listPersonalNetworkModel.value;

        return SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Sua Rede de Apoio',
                  style: AppTextStyleTheme.title,
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 13),
                  scrollDirection: Axis.horizontal,
                  itemCount: listPersonalNetworkModel.length,
                  itemBuilder: (context, index) {
                    PersonalNetworkModel personalNetworkModel =
                        listPersonalNetworkModel[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        spacing: 5,
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundImage: personalNetworkModel.image == null
                                ? null
                                : NetworkImage(
                                    personalNetworkModel.image!,
                                  ),
                            child: personalNetworkModel.image == null
                                ? Text(
                                    personalNetworkModel.name[0],
                                    style: AppTextStyleTheme.title,
                                  )
                                : null,
                          ),

                          Text(
                            FormatTextsUtil.replaceRange(
                              personalNetworkModel.name,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
