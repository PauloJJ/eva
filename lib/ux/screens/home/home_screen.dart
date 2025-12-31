import 'package:eva/models/user_model.dart';
import 'package:eva/services/animations_controller_service.dart';
import 'package:eva/services/auth_app_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/support_network_component.dart';
import 'package:eva/ux/screens/home/widgets/card_sos_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserService userService = Get.find();
  final AnimationsControllerService animationsControllerService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        UserModel userModel = userService.userModel.value!;

        return Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {
                  AuthAppService authAppService = Get.find();
                  authAppService.logout();
                },
                child: Text('teste'),
              ),
            ],
            toolbarHeight: 70,
            title: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  userModel.profileImage,
                ),
                radius: 27,
              ),
              title: Text(
                'Bem vinda',
              ),
              subtitle: Text(
                userModel.name,
                style: AppTextStyleTheme.title.apply(
                  color: color.tertiary,
                  fontSizeDelta: 3,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    animationsControllerService.animationHomeFade(
                      SupportNetworkComponent(),
                    ),

                    SizedBox(height: 30),

                    CardSosWidget(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
