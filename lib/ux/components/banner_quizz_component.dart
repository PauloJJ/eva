import 'package:eva/services/admob_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/screens/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerQuizzComponent extends StatelessWidget {
  BannerQuizzComponent({super.key});

  final AdmobService admobService = Get.find<AdmobService>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        admobService.showIntersticialGeneral(true);
        Get.to(() => QuizScreen());
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color.secondary,
        ),

        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: -20,
              child: Image.asset(
                'assets/images/banner_quizz.png',
                height: 170,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quiz,\nAmor ou Controle?',
                          style: AppTextStyleTheme.h2,
                        ),

                        SizedBox(height: 10),

                        ButtonsComponent.buttonOutline(
                          title: 'Iniciar',
                          height: 35,
                          function: () {
                            admobService.showIntersticialGeneral(true);

                            Get.to(() => QuizScreen());
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 140),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
