import 'package:eva/services/quiz_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/screens/quiz/widgets/card_init_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class InitWidget extends StatelessWidget {
  InitWidget({super.key});

  final QuizService quizService = Get.find<QuizService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voltar'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: color.secondary,
                height: 200,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Image.asset(
                      'assets/images/quiz_01.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Quiz\nAmor ou Controle?',
                textAlign: TextAlign.center,
                style: AppTextStyleTheme.h1,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CardInitWidget(
                      number: '01',
                      title:
                          'Responda com sinceridade. Este teste é sigiloso e tem como objetivo identificar sinais de violência emocional, psicológica, patrimonial, física ou controle abusivo',
                    ),

                    SizedBox(height: 15),

                    CardInitWidget(
                      number: '02',
                      title: '100% Sigiloso e Seguro',
                    ),

                    SizedBox(height: 15),

                    CardInitWidget(
                      number: '03',
                      title: 'Cada resposta “SIM” soma pontos.',
                    ),

                    SizedBox(height: 30),

                    FilledButton(
                      onPressed: () {
                        quizService.isInit.value = false;
                      },
                      child: SizedBox(
                        width: size.width,
                        height: 55,
                        child: Center(
                          child: Text(
                            'Estou pronta para começar!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
