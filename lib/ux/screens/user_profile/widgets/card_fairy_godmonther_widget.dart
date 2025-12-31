import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/screens/fairy_godmothers/fairy_godmothers_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardFairyGodmontherWidget extends StatelessWidget {
  const CardFairyGodmontherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => FairyGodmothersScreen());
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
              bottom: -30,
              right: -20,
              child: Image.asset(
                'assets/images/fairy_godmonther.png',
                height: 190,
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
                          'Fadas Madrinhas',
                          style: AppTextStyleTheme.h1,
                        ),

                        Text(
                          'Psicólogas, advogadas, assistentes sociais e mulheres voluntárias para te ajudar',
                          style: AppTextStyleTheme.subTitle.apply(
                            color: color.primary,
                          ),
                        ),

                        SizedBox(height: 10),
                      ],
                    ),
                  ),

                  SizedBox(width: 130),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
