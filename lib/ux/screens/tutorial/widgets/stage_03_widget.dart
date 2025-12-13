import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:flutter/material.dart';

class Stage03Widget extends StatelessWidget {
  const Stage03Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            width: size.width,
            color: color.secondary,
            child: Column(
              children: [
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/tutorial_03.png',
                  height: 350,
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                'Fadas Madrinhas',
                style: AppTextStyleTheme.h1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Na Eva, você pode apoiar outras mulheres se cadastrando como voluntária e deixando seu contato disponível para quem precisar falar com você.',
                textAlign: TextAlign.center,
                style: AppTextStyleTheme.subTitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
