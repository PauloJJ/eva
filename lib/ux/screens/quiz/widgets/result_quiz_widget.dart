import 'package:eva/services/quiz_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

class ResultQuizWidget extends StatelessWidget {
  ResultQuizWidget({super.key});

  final QuizService quizService = Get.find<QuizService>();

  @override
  Widget build(BuildContext context) {
    if (quizService.resultStatus.value == ResultStatus.lowRisk) {
      return Result(
        cardResultTitle: 'Baixo Risco',
        cardResultSubtitle: 'de 3 a 7 Pontos',
        titleCardColor: Colors.white,
        cardColor: Colors.green,
        iconCard: Icons.check_circle,
        colorIconCard: Colors.green,
        imagePath: 'assets/images/quiz_02.png',
        cardInformationTitle:
            'Não identificamos sinais fortes de relacionamento abusivo no momento. Relações saudáveis são construídas com respeito, confiança e segurança emocional.',
        cardInformationColor: color.secondary,
        cardInformationColorTitleAndButton: color.primary,
        listGuidelines: [
          'Observe sinais de controle emocional.',
          'Mantenha rede de apoio ativa.',
          'Preserve sua autonomia financeira e emocional.',
          'Refaça o teste caso a situação mude.',
        ],
      );
    }

    if (quizService.resultStatus.value == ResultStatus.mediumRisk) {
      return Result(
        cardResultTitle: 'MÉDIO RISCO',
        cardResultSubtitle: 'De 15 a 17 pontos',
        cardColor: Color.fromARGB(255, 229, 156, 0),
        titleCardColor: Colors.white,
        iconCard: Icons.error_outline_outlined,
        colorIconCard: Color.fromARGB(255, 205, 119, 0),
        imagePath: 'assets/images/quiz_03.png',
        cardInformationTitle:
            'Seu relacionamento apresenta sinais importantes de abuso emocional, psicológico ou controle. Esses comportamentos podem evoluir para situações mais graves.',
        cardInformationColor: Color.fromARGB(255, 255, 196, 0),
        cardInformationColorTitleAndButton: Colors.black,
        listGuidelines: [
          'Mantenha contato com sua rede de apoio (familiares, amigas, vizinhos ou pessoas de confiança).',
          'Evite o isolamento emocional e social.',
          'Procure orientação das Fadas Madrinhas no aplicativo.',
          'Busque apoio psicológico e emocional especializado.',
          'Guarde mensagens, prints, áudios ou outras provas importantes em local seguro.',
          'Caso se sinta insegura, procure a Delegacia Especializada de Atendimento à Mulher (DEAM).',
          'Se sua cidade não possuir DEAM, procure a delegacia mais próxima para orientação e proteção.',
          'Você pode pedir ajuda mesmo sem registrar ocorrência naquele momento.',
        ],
        titleEmotional:
            'Violência não começa apenas com agressões físicas. Controle, medo e humilhação também são sinais de alerta.',
      );
    }

    return Result(
      cardResultTitle: 'ALTO RISCO',
      cardResultSubtitle: '18 ou Mais',
      cardColor: Colors.red,
      titleCardColor: Colors.white,
      iconCard: Icons.error,
      colorIconCard: Colors.red,
      imagePath: 'assets/images/quiz_04.png',
      cardInformationTitle:
          'Há fortes indícios de relacionamento abusivo com risco elevado de agravamento da violência.',
      cardInformationColor: Colors.red,
      cardInformationColorTitleAndButton: Colors.white,
      listGuidelines: [
        'Acione imediatamente a Polícia Militar pelo telefone 190 em situações de emergência ou ameaça iminente.',
        'Procure um local seguro e mantenha contato com sua rede de apoio.',
        'Informe familiares, amigas ou pessoas de confiança sobre a situação.',
        'Busque auxílio imediato das Fadas Madrinhas do aplicativo.',
        'Procure atendimento psicológico ou acolhimento emocional especializado.',
        'Dirija-se à Delegacia Especializada de Atendimento à Mulher (DEAM).',
        'Caso não exista DEAM em sua cidade, procure imediatamente a delegacia mais próxima.',
        'Evite permanecer sozinha se estiver se sentindo em risco.',
        'Se possível, mantenha documentos, celular e itens essenciais acessíveis.',
      ],
      titleEmotional:
          'Você não está sozinha. Pedir ajuda é um ato de coragem e proteção.',
    );
  }
}

class Result extends StatelessWidget {
  final String cardResultTitle;
  final String cardResultSubtitle;
  final Color cardColor;
  final Color titleCardColor;
  final IconData iconCard;
  final Color colorIconCard;
  final String imagePath;
  final String cardInformationTitle;
  final Color cardInformationColor;
  final Color cardInformationColorTitleAndButton;
  final List<String> listGuidelines;
  final String? titleEmotional;

  const Result({
    super.key,
    required this.cardResultTitle,
    required this.cardResultSubtitle,
    required this.cardColor,
    required this.titleCardColor,
    required this.iconCard,
    required this.colorIconCard,
    required this.imagePath,
    required this.cardInformationTitle,
    required this.cardInformationColor,
    required this.cardInformationColorTitleAndButton,
    required this.listGuidelines,
    this.titleEmotional,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        QuizService quizService = Get.find<QuizService>();

        quizService.reset();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Resultado'),
        ),
        body: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      color: cardColor,
                      child: ListTile(
                        title: Text(
                          cardResultTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: titleCardColor,
                          ),
                        ),
                        subtitle: Text(
                          cardResultSubtitle,
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            iconCard,
                            color: colorIconCard,
                            size: 30,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Card(
                      elevation: 0,
                      color: cardInformationColor,
                      margin: EdgeInsets.all(0),
                      child: SizedBox(
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Image.asset(
                                imagePath,
                                height: 150,
                              ),

                              SizedBox(height: 15),

                              Text(
                                cardInformationTitle,
                                textAlign: TextAlign.center,
                                style: AppTextStyleTheme.subTitle.apply(
                                  color: cardInformationColorTitleAndButton,
                                  fontSizeDelta: 4,
                                ),
                              ),

                              SizedBox(height: 20),

                              ButtonsComponent.buttonOutline(
                                title: 'Ver Repostas',
                                color: cardInformationColorTitleAndButton,
                                titleColor: cardInformationColorTitleAndButton,
                                function: () {},
                              ),

                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    Text(
                      'Orientações',
                      style: AppTextStyleTheme.title,
                    ),

                    SizedBox(height: 10),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listGuidelines.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                            color: Colors.grey.shade100,
                            margin: EdgeInsets.all(0),
                            elevation: 0,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              title: Text(
                                listGuidelines[index],
                                style: TextStyle(color: Colors.grey.shade800),
                              ),
                              leading: Icon(
                                Icons.check_circle_outline,
                                color: color.primary,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    if (titleEmotional != null) ...[
                      SizedBox(height: 10),
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.all(0),
                        color: color.secondary,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          title: Text(
                            titleEmotional!,
                            style: TextStyle(
                              color: color.primary,
                            ),
                          ),
                          leading: Icon(
                            Icons.security,
                            color: color.primary,
                            size: 35,
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 30),

                    ButtonsComponent.buttonFilled(
                      title: 'Retornar ao início',
                      function: () {
                        QuizService quizService = Get.find<QuizService>();
                        quizService.reset();
                      },
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
