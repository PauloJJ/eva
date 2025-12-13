import 'package:eva/services/animations_controller_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/sos_button_component.dart';
import 'package:eva/ux/screens/home/widgets/cards_information_widget.dart';
import 'package:eva/ux/screens/sos_timer/sos_timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardSosWidget extends StatelessWidget {
  CardSosWidget({super.key});

  final AnimationsControllerService animationsControllerService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      elevation: 0,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      margin: EdgeInsets.all(0),
      color: color.secondary,
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 10),
              animationsControllerService.animationHomeFade(
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color.tertiary,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        title: Text(
                          'Precisa de Ajuda?',
                          style: AppTextStyleTheme.title02.apply(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Acione botão e notificaremos sua rede',
                          style: TextStyle(
                            color: color.secondary,
                          ),
                        ),

                        trailing: Icon(
                          Icons.volume_up_outlined,
                          color: color.secondary,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              animationsControllerService.animationHomeFade(
                SosButtonComponent(
                  title: 'SOS',
                  titleSize: 55,
                  subTitle: 'Clique para\nIniciar',
                  function: () {
                    Get.to(() => SosTimerScreen());
                  },
                ),
              ),

              SizedBox(height: 20),

              Text(
                'O que o SOS vai fazer?',
                style: AppTextStyleTheme.title02.apply(color: color.tertiary),
              ),

              SizedBox(height: 10),

              Text(
                'EVA enviará as seguintes informações para sua rede de apoio',
                textAlign: TextAlign.center,
                style: AppTextStyleTheme.subTitle.apply(color: color.tertiary),
              ),

              SizedBox(height: 20),

              Wrap(
                children: [
                  CardsInformationWidget(
                    title: 'Enviar\nSMS',
                    iconData: Icons.sms_outlined,
                  ),

                  CardsInformationWidget(
                    title: 'Ligar\n190',
                    iconData: Icons.local_police_outlined,
                  ),

                  CardsInformationWidget(
                    title: 'Enviar\nLocalização',
                    iconData: Icons.person_pin_circle_outlined,
                  ),

                  CardsInformationWidget(
                    title: 'Grava\nÁudio',
                    iconData: Icons.keyboard_voice_outlined,
                  ),

                  CardsInformationWidget(
                    title: 'Grava\nVídeo',
                    iconData: Icons.video_camera_back_outlined,
                  ),

                  CardsInformationWidget(
                    title: 'Enviar\nE-mail',
                    iconData: Icons.email_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
