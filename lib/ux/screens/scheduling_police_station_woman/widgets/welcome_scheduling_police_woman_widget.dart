import 'package:eva/services/hive_service.dart';
import 'package:eva/services/scheduling_police_station_woman_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSchedulingPoliceWomanWidget extends StatelessWidget {
  WelcomeSchedulingPoliceWomanWidget({super.key});

  final SchedulingPoliceStationWomanService
  schedulingPoliceStationWomanService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ButtonsComponent.buttonFilled(
          title: 'Continuar',
          function: () {
            HiveService hiveService = Get.find();
            hiveService.firstSchedulingPolice.value = false;
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/scheduling_police_station_woman_component_01.png',
                  height: 240,
                ),

                SizedBox(height: 20),

                Text(
                  'Agendamento Delegacia da Mulher',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Text(
                            '01',
                            style: AppTextStyleTheme.h2,
                          ),
                        ),

                        SizedBox(width: 20),

                        Expanded(
                          child: Text(
                            'Este agendamento está disponível somente para Governador Valadares.',
                            style: AppTextStyleTheme.subTitle.apply(
                              fontSizeDelta: 2.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 5),

                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Text(
                            '02',
                            style: AppTextStyleTheme.h2,
                          ),
                        ),

                        SizedBox(width: 20),

                        Expanded(
                          child: Text(
                            'A Delegacia da Mulher atende: violência física, psicológica, ameaças, medidas protetivas, etc.',
                            style: AppTextStyleTheme.subTitle.apply(
                              fontSizeDelta: 2.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
