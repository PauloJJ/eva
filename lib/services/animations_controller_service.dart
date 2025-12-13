import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class AnimationsControllerService extends GetxController {
  RxBool automacticHomeAnimation = true.obs;

  animationHomeFade(Widget widget) {
    return widget
        .animate(
          onComplete: (controller) {
            automacticHomeAnimation.value = false;
          },
        )
        .fade(
          begin: automacticHomeAnimation.value == false ? 1 : 0,
          duration: Duration(seconds: 1),
        );
  }
}
