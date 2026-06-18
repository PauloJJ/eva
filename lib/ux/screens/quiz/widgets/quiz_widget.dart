import 'package:eva/models/quiz_model.dart';
import 'package:eva/services/admob_service.dart';
import 'package:eva/services/quiz_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class QuizWidget extends StatelessWidget {
  QuizWidget({super.key});

  final QuizService quizService = Get.find<QuizService>();

  final AdmobService admobService = Get.find<AdmobService>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        FeedbackComponent.alertConfirmation(
          content: 'Você está prestes a encerrar o quiz. Deseja continuar?',
          function: () {
            Get.back();
            quizService.reset();
          },
        );
      },
      child: Obx(
        () {
          final bannerAd = admobService.bannerQuiz.value;

          return Scaffold(
            appBar: AppBar(
              title: Text('Encerrar Quiz'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),

                          Text(
                            'Questão ${quizService.pageIndex.value + 1} de 25',
                            style: TextStyle(
                              color: color.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          LinearProgressIndicator(
                            minHeight: 10,
                            backgroundColor: Colors.grey.shade300,
                            value: ((quizService.pageIndex.value + 1) * 0.040),
                            borderRadius: BorderRadius.circular(800),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height / 1.9,
                      child: PageView.builder(
                        controller: quizService.pageController,
                        itemCount: quizService.quizQuestions.length,
                        physics: NeverScrollableScrollPhysics(),

                        itemBuilder: (context, index) {
                          QuizModel quizModel =
                              quizService.quizQuestions[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),

                                Card(
                                  margin: EdgeInsets.all(0),
                                  elevation: 0,
                                  color: color.secondary,
                                  child: SizedBox(
                                    width: size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),

                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    800,
                                                  ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 80,
                                                    vertical: 3,
                                                  ),
                                              child: Text(
                                                quizModel.id.toString().padLeft(
                                                  2,
                                                  '0',
                                                ),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 40),

                                          Text(
                                            quizModel.question,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: color.primary,
                                              fontSize: 18,
                                            ),
                                          ),

                                          SizedBox(height: 40),

                                          FilledButton(
                                            onPressed: () {
                                              quizService.addAndNextStep(
                                                isAdd: true,
                                                indexQuestion: index,
                                              );
                                            },
                                            child: SizedBox(
                                              width: size.width,
                                              height: 55,
                                              child: Center(
                                                child: Text(
                                                  'Sim',
                                                  style: AppTextStyleTheme.title
                                                      .apply(
                                                        fontSizeDelta: 5,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 15),

                                          FilledButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                    Color(0xFFD5D5D5),
                                                  ),
                                            ),
                                            onPressed: () {
                                              quizService.addAndNextStep(
                                                isAdd: false,
                                                indexQuestion: index,
                                              );
                                            },
                                            child: SizedBox(
                                              width: size.width,
                                              height: 55,
                                              child: Center(
                                                child: Text(
                                                  'Não',
                                                  style: AppTextStyleTheme.title
                                                      .apply(
                                                        fontSizeDelta: 5,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 20),

                                          Center(
                                            child: Text(
                                              'Sua resposta é 100% sigilosa e fundamental para sua avaliação de risco.',
                                              style: AppTextStyleTheme.subTitle
                                                  .apply(
                                                    fontStyle: FontStyle.italic,
                                                    color: color.primary,
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),

                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          if (bannerAd != null)
                            SizedBox(
                              width: size.width,
                              height: 90,
                              child: AdWidget(ad: bannerAd),
                            ),

                          SizedBox(height: 20),

                          CircleAvatar(
                            radius: 28,
                            backgroundColor: color.primary.withAlpha(30),
                            child: Icon(
                              Icons.security_outlined,
                              color: color.primary,
                              size: 30,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            'Estamos aqui para ouvir e proteger. Este quiz ajuda a identificar padrões que podem não estar claros no dia a dia.',
                            style: AppTextStyleTheme.subTitle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
