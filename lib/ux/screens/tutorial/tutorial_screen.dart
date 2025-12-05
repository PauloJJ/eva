import 'package:eva/services/tutorial_service.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/screens/tutorial/widgets/stage_01_widget.dart';
import 'package:eva/ux/screens/tutorial/widgets/stage_02_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

class TutorialScreen extends StatelessWidget {
  TutorialScreen({super.key});

  final TutorialService tutorialService = Get.put(TutorialService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ButtonsComponent.buttonFilled(
          title: 'Avançar',
          function: () {
            tutorialService.nextStep(1);
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: tutorialService.pageController,

          physics: NeverScrollableScrollPhysics(),
          children: [
            Stage01Widget(),
            Stage02Widget(),
          ],
        ),
      ),
    );
  }
}
