import 'package:eva/services/actions_service.dart';
import 'package:eva/services/bottom_navigation_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:eva/ux/components/card_action_component.dart';
import 'package:eva/ux/screens/actions/widgets/card_deam_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionsScreen extends StatelessWidget {
  ActionsScreen({super.key});

  final ActionsService actionsService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                CardDeamWidget(),

                SizedBox(height: 40),

                Text(
                  'Ações de Evidências',
                  style: AppTextStyleTheme.title,
                ),

                SizedBox(height: 10),

                CardActionComponent(
                  title: 'Fotografar',
                  image: 'assets/images/actions_component_02.png',
                  function: () {
                    actionsService.pickImageAndSave();
                  },
                ),

                SizedBox(height: 10),

                CardActionComponent(
                  title: 'Gravar Vídeo',
                  image: 'assets/images/actions_component_03.png',
                  function: () {
                    actionsService.pickVideoAndSave();
                  },
                ),

                SizedBox(height: 10),

                CardActionComponent(
                  title: 'Gravar Áudio',
                  image: 'assets/images/actions_component_04.png',
                  function: () {
                    actionsService.recordAudio();
                  },
                ),

                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: ButtonsComponent.buttonTextButon(
                    title: 'Ver suas Provas e Registros',
                    function: () {
                      BottomNavigationService bottomNavigationService =
                          Get.find();

                      bottomNavigationService.navigatorPage(2);
                    },
                  ),
                ),

                SizedBox(height: 30),

                Text(
                  'Ações de Emergência',
                  style: AppTextStyleTheme.title,
                ),

                SizedBox(height: 10),

                CardActionComponent(
                  title: 'Ligar para 190',
                  image: 'assets/images/actions_component_06.png',
                  function: () {
                    actionsService.dial190();
                  },
                ),

                SizedBox(height: 10),

                CardActionComponent(
                  title: 'Enviar Localização WhatsApp',
                  image: 'assets/images/actions_component_05.png',
                  function: () {
                    actionsService.sendLocalizationWhatsapp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
