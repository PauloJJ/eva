import 'package:eva/models/personal_network_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/screens/add_or_remove_personal_network/add_or_remove_personal_network_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportNetworkWidget extends StatelessWidget {
  SupportNetworkWidget({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PersonalNetworkModel> listPersonalNetworkModel =
        userService.listPersonalNetworkModel.value;

    return InkWell(
      onTap: () {
        Get.to(() => AddOrRemovePersonalNetworkScreen());
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: color.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listPersonalNetworkModel.length > 3
                      ? 3
                      : listPersonalNetworkModel.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: AlignmentGeometry.centerLeft,
                      widthFactor: 0.7,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              listPersonalNetworkModel[index].image == null
                              ? null
                              : NetworkImage(
                                  listPersonalNetworkModel[index].image!,
                                ),
                          child: listPersonalNetworkModel[index].image == null
                              ? Text(listPersonalNetworkModel[index].name[0])
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(width: 20),

            SizedBox(
              height: 40,
              child: VerticalDivider(),
            ),

            SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tamanho',
                    style: AppTextStyleTheme.subTitle,
                  ),

                  Text(
                    listPersonalNetworkModel.length.toString(),
                    style: AppTextStyleTheme.h1,
                  ),
                ],
              ),
            ),

            SizedBox(width: 30),

            Icon(Icons.arrow_forward_outlined),
          ],
        ),
      ),
    );
  }
}
