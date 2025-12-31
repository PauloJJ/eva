import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';

class CardDeamWidget extends StatelessWidget {
  const CardDeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              child: Image.asset(
                'assets/images/actions_component_01.png',
                height: 120,
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
                          'Deam',
                          style: AppTextStyleTheme.h1,
                        ),

                        Text(
                          'Agende seu atendimento na Delegacia da Mulher.',
                          style: AppTextStyleTheme.subTitle.apply(
                            color: color.primary,
                          ),
                        ),

                        SizedBox(height: 10),

                        ButtonsComponent.buttonOutline(
                          title: 'Agendar',
                          height: 35,
                          function: () {},
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
