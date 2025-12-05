import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TutorialService extends GetxController {
  PageController pageController = PageController();

  RxInt stage = 0.obs;

  nextStep(int step) {
    stage.value = step;

    pageController.animateToPage(
      1,
      duration: Duration(seconds: 1),
      curve: Curves.easeOutCubic,
    );
  }
}
