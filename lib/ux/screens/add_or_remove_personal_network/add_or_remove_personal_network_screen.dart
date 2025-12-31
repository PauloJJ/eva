import 'package:eva/models/personal_network_model.dart';
import 'package:eva/services/add_or_remove_personal_network_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/screens/add_or_remove_personal_network/widgets/list_personal_network_is_empty_widget.dart';
import 'package:eva/ux/screens/add_or_remove_personal_network/widgets/list_personal_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrRemovePersonalNetworkScreen extends StatelessWidget {
  AddOrRemovePersonalNetworkScreen({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<PersonalNetworkModel> listPersonalNetworkModel =
            userService.listPersonalNetworkModel.value;

        return Scaffold(
          appBar: AppBar(
            title: Text('Cadastrar na Rede'),
            actionsPadding: EdgeInsets.symmetric(horizontal: 15),
            actions: [
              IconButton(
                onPressed: () {
          

                  AddOrRemovePersonalNetworkService().showBottomAddOrEditPersonal(
                    isEdit: false,
                  );
                },
                icon: Icon(
                  Icons.person_add_alt_1,
                  color: color.primary,
                  size: 30,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adicione ao menos uma pessoa de confiança antes de continuar. Assim, a Eva poderá cuidar melhor de você.',
                    style: AppTextStyleTheme.subTitle,
                  ),

                  if (listPersonalNetworkModel.isEmpty) ...[
                    SizedBox(height: size.height / 3.5),
                    ListPersonalNetworkIsEmptyWidget(),
                  ],

                  if (listPersonalNetworkModel.isNotEmpty) ...[
                    SizedBox(height: 20),
                    ListPersonalWidget(),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
