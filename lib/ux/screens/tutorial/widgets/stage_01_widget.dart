import 'package:eva/themes/app_text_style_theme.dart';
import 'package:flutter/material.dart';

class Stage01Widget extends StatelessWidget {
  const Stage01Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Image.asset('assets/images/tutorial_01.png'),
        ),

        SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                'Cadastrar Rede',
                style: AppTextStyleTheme.h1,
              ),
              SizedBox(height: 10),
              Text(
                'Crie sua rede de confiança, pessoas que o Eva avisará imediatamente se você estiver em perigo. Você nunca estará sozinha. 💜',
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
