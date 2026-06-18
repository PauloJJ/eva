import 'package:eva/models/quiz_model.dart';
import 'package:eva/services/admob_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

enum ResultStatus { lowRisk, mediumRisk, highRisk }

class QuizService extends GetxController {
  RxBool isInit = true.obs;
  RxInt points = 0.obs;
  RxInt pageIndex = 0.obs;

  final PageController pageController = PageController();

  Rx<List<QuizModel>> quizAnswer = Rx([]);

  final List<QuizModel> quizQuestions = [
    {
      'id': 1,
      'question':
          'Seu parceiro controla suas roupas, amizades ou redes sociais?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 2,
      'question': 'Ele demonstra ciúmes excessivos frequentemente?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 3,
      'question': 'Você evita certas atitudes por medo da reação dele?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 4,
      'question': 'Ele lê suas mensagens ou exige senhas?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 5,
      'question': 'Já fez você se afastar de amigos ou familiares?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 6,
      'question': 'Faz críticas constantes que diminuem sua autoestima?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 7,
      'question': 'Faz chantagem emocional para conseguir o que quer?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 8,
      'question': 'Já impediu você de estudar ou trabalhar?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 9,
      'question': 'Controla seu dinheiro ou gastos?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 10,
      'question': 'Faz ligações ou mensagens insistentes para monitorar você?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 11,
      'question': 'Você sente que perdeu sua liberdade dentro da relação?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 12,
      'question':
          'Ele costuma inverter situações e fazer você se sentir culpada?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 13,
      'question': 'Você sente medo de terminar o relacionamento?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 14,
      'question': 'Você se sente emocionalmente esgotada na relação?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 15,
      'question': 'Ele já ameaçou tirar os filhos de você?',
      'points': 1,
      'redFlag': false,
      'forceRed': false,
    },

    // Risco moderado/alto (2 pontos)
    {
      'id': 16,
      'question':
          'Já empurrou, segurou com força ou destruiu objetos durante brigas?',
      'points': 2,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 17,
      'question':
          'Já perseguiu você, apareceu inesperadamente ou monitorou seus passos?',
      'points': 2,
      'redFlag': true,
      'forceRed': false,
    },
    {
      'id': 18,
      'question': 'Já ameaçou machucar você, familiares ou animais?',
      'points': 2,
      'redFlag': true,
      'forceRed': false,
    },
    {
      'id': 19,
      'question': 'Já obrigou você a manter relações sexuais sem vontade?',
      'points': 2,
      'redFlag': true,
      'forceRed': false,
    },
    {
      'id': 20,
      'question': 'O comportamento dele piorou nos últimos meses?',
      'points': 2,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 21,
      'question':
          'Ele faz uso abusivo de álcool ou drogas e se torna agressivo?',
      'points': 2,
      'redFlag': false,
      'forceRed': false,
    },
    {
      'id': 22,
      'question': 'Você já tentou terminar, mas teve medo ou não conseguiu?',
      'points': 2,
      'redFlag': true,
      'forceRed': false,
    },

    // Altíssimo risco (3 pontos)
    {
      'id': 23,
      'question': 'Ele já tentou enforcar, sufocar ou estrangular você?',
      'points': 3,
      'redFlag': true,
      'forceRed': true,
    },
    {
      'id': 24,
      'question':
          'Já ameaçou matar você ou disse frases como: "Se não for minha, não será de ninguém"?',
      'points': 3,
      'redFlag': true,
      'forceRed': true,
    },
    {
      'id': 25,
      'question': 'Ele possui arma de fogo ou fácil acesso a armas?',
      'points': 3,
      'redFlag': true,
      'forceRed': false,
    },
  ].map((e) => QuizModel.fromJson(e)).toList();

  Rx<ResultStatus?> resultStatus = Rx(null);

  final AdmobService admobService = Get.find();

  @override
  void onInit() {
    pageController.addListener(() {
      pageIndex.value = pageController.page!.toInt();
    });

    admobService.loadBannerQuiz();

    super.onInit();
  }

  addAndNextStep({required bool isAdd, required int indexQuestion}) {
    if (isAdd == true) {
      quizAnswer.value.add(quizQuestions[indexQuestion]);
      quizAnswer.update((val) {});
    }

    showResult(indexQuestion);

    pageController.animateToPage(
      (indexQuestion + 1),
      duration: Duration(milliseconds: 500),
      curve: Curves.decelerate,
    );
  }

  showResult(int indexQuestion) {
    int calcPoint = 0;
    List<QuizModel> questions18And22 = [];

    for (var quizModel in quizAnswer.value) {
      calcPoint = (calcPoint + quizModel.points);

      if (quizModel.forceRed == true) {
        resultStatus.value = ResultStatus.highRisk;
        return;
      }

      if (quizModel.id == 18 || quizModel.id == 22) {
        questions18And22.add(quizModel);
      }
    }

    if (questions18And22.length >= 2) {
      resultStatus.value = ResultStatus.highRisk;
      return;
    }

    if (indexQuestion >= 24) {
      if (calcPoint <= 7) {
        resultStatus.value = ResultStatus.lowRisk;
        return;
      }

      if (calcPoint >= 8 && calcPoint <= 17) {
        resultStatus.value = ResultStatus.mediumRisk;
        return;
      }

      if (calcPoint >= 18) {
        resultStatus.value = ResultStatus.highRisk;
        return;
      }
    }
  }

  reset() {
    admobService.showIntersticialGeneral(true);

    isInit.value = true;
    points.value = 0;
    pageIndex.value = 0;

    quizAnswer.value = [];
    resultStatus.value = null;
  }
}
