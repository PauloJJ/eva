import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TutorialService extends GetxController {
  PageController pageController = PageController();

  RxInt stage = 0.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    UserService userService = Get.find();
    userService.updatingLocation();

    super.onInit();
  }

  nextStep(int step) {
    UserService userService = Get.find();

    if (step == 2 && userService.listPersonalNetworkModel.value.isEmpty) {
      return FeedbackComponent.definitiveError(
        message: 'Cadastre pelo menos uma pessoa na sua rede de apoio.',
      );
    }

    stage.value = step;

    pageController.animateToPage(
      step,
      duration: Duration(seconds: 1),
      curve: Curves.easeOutCubic,
    );
  }

  getCurrentLocalization() async {
    UserService userService = Get.find();

    isLoading.value = true;

    bool permittedLocation = await userService.updatingLocation();

    if (permittedLocation == true) {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'didTheTutorial': true,
      });
    }

    isLoading.value = false;
  }
}
