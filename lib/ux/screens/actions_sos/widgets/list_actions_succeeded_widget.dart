import 'package:eva/services/actions_sos_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListActionsSucceededWidget extends StatelessWidget {
  ListActionsSucceededWidget({super.key});

  final ActionsSosService actionsSosService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ListView.builder(
          itemCount: actionsSosService.listSucceded.value.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Obx(
              () {
                String title =
                    actionsSosService.listSucceded.value[index]['title'];

                bool successfulAction = actionsSosService
                    .listSucceded
                    .value[index]['successfulAction'];

                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: color.secondary,
                        child: Text(
                          (index + 1).toString(),

                          style: AppTextStyleTheme.title.apply(
                            color: color.onSecondary,
                          ),
                        ),
                      ),
                      title: Text(
                        title,
                        style: AppTextStyleTheme.title,
                      ),
                      trailing: SizedBox(
                        height: 30,
                        width: 30,
                        child: successfulAction == true
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30,
                              )
                            : CircularProgressIndicator.adaptive(),
                      ),
                    ),

                    Divider(
                      color: Color(0xFFE8E8E8),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
