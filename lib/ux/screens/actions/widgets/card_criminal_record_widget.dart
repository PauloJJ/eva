import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/screens/criminal_record/criminal_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCriminalRecordWidget extends StatelessWidget {
  const CardCriminalRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CriminalRecordScreen());
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
              right: 0,
              child: Hero(
                tag: 'image_police_01',
                child: Image.asset(
                  'assets/images/actions_component_07.png',
                  height: 180,
                ),
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
                          'Nada Consta',
                          style: AppTextStyleTheme.h1,
                        ),

                        Text(
                          'Veja os antecedentes criminais de pessoas próximas a você.',
                          style: AppTextStyleTheme.subTitle.apply(
                            color: color.primary,
                          ),
                        ),

                        SizedBox(height: 10),

                        ButtonsComponent.buttonOutline(
                          title: 'Buscar',
                          height: 35,
                          function: () {
                            Get.to(() => CriminalRecordScreen());
                          },
                        ),
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
