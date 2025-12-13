import 'package:eva/services/sos_timer_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/format_text_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/sos_button_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SosTimerScreen extends StatelessWidget {
  SosTimerScreen({super.key});

  final UserService userService = Get.find();
  final SosTimerService sosTimerService = Get.put(SosTimerService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            sosTimerService.cancelTimer();
          },
          child: Scaffold(
            body: Container(
              height: size.height,
              width: size.width,
              color: Color(0xFF765689),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mantenha a\ncalma, ${FormatTextsUtil.replaceRange(userService.userModel.value!.name)}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A Eva vai avisar sua rede de apoio e ficar ao seu lado neste momento difícil. Você não está sozinha',
                    textAlign: TextAlign.center,
                    style: AppTextStyleTheme.subTitle.apply(
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    sosTimerService.timerSos.value.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 70,
                    ),
                  ),

                  SosButtonComponent(
                    title: 'Cancelar',
                    titleSize: 40,
                    subTitle: 'Clique apenas uma\nvez para cancelar',
                    function: () {
                      sosTimerService.cancelTimer();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
