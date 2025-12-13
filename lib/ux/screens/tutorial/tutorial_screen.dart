import 'package:eva/services/tutorial_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/screens/tutorial/widgets/stage_01_widget.dart';
import 'package:eva/ux/screens/tutorial/widgets/stage_02_widget.dart';
import 'package:eva/ux/screens/tutorial/widgets/stage_03_widget.dart';
import 'package:eva/ux/screens/tutorial/widgets/stage_04_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialScreen extends StatelessWidget {
  TutorialScreen({super.key});

  final TutorialService tutorialService = Get.put(TutorialService());

  final UserService userService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        int stage = tutorialService.stage.value;

        bool isLoading = tutorialService.isLoading.value;

        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SizedBox(
              height: 55,
              width: size.width,
              child: ButtonsComponent.buttonFilled(
                isLoading: isLoading,
                title: stage == 3 ? 'Permitir e concluir' : 'Avançar',
                function: () {
                  if (stage == 0) {
                    tutorialService.nextStep(1);
                  } else if (stage == 1) {
                    tutorialService.nextStep(2);
                  } else if (stage == 2) {
                    tutorialService.nextStep(3);
                  } else {
                    tutorialService.getCurrentLocalization();
                  }
                },
              ),
            ),
          ),
          body: SafeArea(
            child: PageView(
              controller: tutorialService.pageController,

              physics: NeverScrollableScrollPhysics(),
              children: [
                Stage01Widget(),
                Stage02Widget(),
                Stage03Widget(),
                Stage04Widget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
