import 'dart:async';
import 'package:eva/ux/screens/actions_sos/actions_sos_screen.dart';
import 'package:eva/ux/screens/sos_timer/sos_timer_screen.dart';
import 'package:get/get.dart';

class SosTimerService extends GetxController {
  RxInt timerSos = 6.obs;

  Timer? timerCancel;

  @override
  void onInit() {
    initSos();
    super.onInit();
  }

  initSos() async {
    Get.to(() => SosTimerScreen());
    initTimerSos();
  }

  initTimerSos() {
    timerCancel = Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        if (timerSos.value <= 0) {
          await Get.off(
            transition: Transition.circularReveal,
            () => ActionsSosScreen(),
          );

          timer.cancel();
          timerSos.value = 6;

          return;
        }

        timerSos.value -= 1;
      },
    );
  }

  cancelTimer() {
    timerCancel?.cancel();

    Get.back();
  }
}
