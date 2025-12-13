import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class GetLocalizationScreen extends StatelessWidget {
  GetLocalizationScreen({super.key});

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Container(
              width: size.width,
              color: color.secondary,
              child: Image.asset(
                'assets/images/tutorial_04.png',
                height: 320,
              ),
            ),
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'A Eva precisa acessar sua localização',
                  style: AppTextStyleTheme.h1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Eva precisa da sua localização para agir rapidamente em momentos difíceis. Só compartilharemos sua posição com a sua rede de confiança',
                  textAlign: TextAlign.center,
                  style: AppTextStyleTheme.subTitle,
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
