import 'package:eva/services/quiz_service.dart';
import 'package:eva/ux/screens/quiz/widgets/init_widget.dart';
import 'package:eva/ux/screens/quiz/widgets/quiz_widget.dart';
import 'package:eva/ux/screens/quiz/widgets/result_quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  final QuizService quizService = Get.put(QuizService());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (quizService.isInit.value == true) {
        return InitWidget();
      }

      if (quizService.resultStatus.value != null) {
        return ResultQuizWidget();
      }

      return QuizWidget();
    });
  }
}
