import 'package:eva/services/actions_service.dart';
import 'package:eva/services/actions_sos_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/support_network_component.dart';
import 'package:eva/ux/screens/actions_sos/widgets/available_cards_widget.dart';
import 'package:eva/ux/screens/actions_sos/widgets/card_is_activated_widget.dart';
import 'package:eva/ux/screens/actions_sos/widgets/list_actions_succeeded_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionsSosScreen extends StatelessWidget {
  ActionsSosScreen({super.key});

  final ActionsSosService actionsSosService = Get.put(ActionsSosService());
  final ActionsService actionsService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.primary
          ),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 55,
            child: Center(
              child: Text(
                'Desativar SOS',
                style: AppTextStyleTheme.title02.apply(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('SOS'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardIsActivatedWidget(),

              SizedBox(height: 40),

              SupportNetworkComponent(),

              SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enviando informações para sua\nrede de aponho',
                      style: AppTextStyleTheme.title,
                    ),

                    SizedBox(height: 5),

                    Text(
                      'A Eva enviará sua localização e uma mensagem de SOS para sua rede de apoio.',
                      style: AppTextStyleTheme.subTitle,
                    ),

                    SizedBox(height: 20),

                    ListActionsSucceededWidget(),

                    SizedBox(height: 50),

                    Text(
                      'Ações disponíveis',
                      style: AppTextStyleTheme.title,
                    ),

                    SizedBox(height: 20),

                    AvailableCardsWidget(
                      iconData: Icons.local_police_outlined,
                      title: 'Ligar para 190',
                      function: () {
                        actionsService.dial190();
                      },
                    ),

                    SizedBox(height: 15),

                    AvailableCardsWidget(
                      iconData: Icons.location_on_outlined,
                      title: 'Enviar Localização WhatsApp',
                      function: () {
                        actionsService.sendLocalizationWhatsapp();
                      },
                    ),

                    SizedBox(height: 15),

                    AvailableCardsWidget(
                      iconData: Icons.add_a_photo_outlined,
                      title: 'Fotografar',
                      function: () {
                        actionsService.pickImageAndSave();
                      },
                    ),

                    SizedBox(height: 15),

                    AvailableCardsWidget(
                      iconData: Icons.video_camera_back_outlined,
                      title: 'Gravar Video',
                      function: () {
                        actionsService.pickVideoAndSave();
                      },
                    ),

                    SizedBox(height: 15),

                    AvailableCardsWidget(
                      iconData: Icons.multitrack_audio_rounded,
                      title: 'Gravar Áudio',
                      function: () {
                        actionsService.recordAudio();
                      },
                    ),

                    SizedBox(height: 50),
                  ],
                ),
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
