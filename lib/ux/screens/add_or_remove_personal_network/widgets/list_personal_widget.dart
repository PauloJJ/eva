import 'package:eva/models/personal_network_model.dart';
import 'package:eva/services/add_or_remove_personal_network_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListPersonalWidget extends StatelessWidget {
  ListPersonalWidget({
    super.key,
  });

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<PersonalNetworkModel> listPersonalNetworkModel =
            userService.listPersonalNetworkModel.value;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listPersonalNetworkModel.length,
          itemBuilder: (context, index) {
            PersonalNetworkModel personalNetworkModel =
                listPersonalNetworkModel[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 10,
                ),

                child: InkWell(
                  onLongPress: () {
                    AddOrRemovePersonalNetworkService().deletePersonal(
                      personalNetworkModel,
                    );
                  },
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    subtitle: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        AddOrRemovePersonalNetworkService().showEditContact(
                          personalNetworkModel: personalNetworkModel,
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Editar contato',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: personalNetworkModel.image == null
                          ? null
                          : NetworkImage(
                              personalNetworkModel.image!,
                            ),
                      child: personalNetworkModel.image == null
                          ? Text(personalNetworkModel.name[0])
                          : null,
                    ),
                    title: Text(
                      personalNetworkModel.name,
                      style: AppTextStyleTheme.title,
                    ),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        title: Text(
                          personalNetworkModel.phoneNumber,
                          style: AppTextStyleTheme.subTitle,
                        ),
                      ),

                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        title: Text(
                          personalNetworkModel.email ?? 'Vazio',
                          style: AppTextStyleTheme.subTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
