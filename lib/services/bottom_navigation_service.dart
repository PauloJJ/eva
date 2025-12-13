import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomNavigationService extends GetxController {
  PageController pageController = PageController();

  RxInt index = 0.obs;

  navigatorPage(int value) {
    index.value = value;

    pageController.animateToPage(
      value,
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }
}
