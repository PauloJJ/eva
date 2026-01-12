import 'package:eva/models/scheduling_policia_station_woman_model.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/scheduling_police_woman_adm_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/open_url_and_email_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ScheduleOrRejectWidget extends StatelessWidget {
  final SchedulingPoliciaStationWomanModel schedulingPoliciaStationWomanModel;
  final UserModel userModel;

  ScheduleOrRejectWidget({
    super.key,
    required this.schedulingPoliciaStationWomanModel,
    required this.userModel,
  });

  final SchedulingPoliceWomanAdmService schedulingPoliceWomanAdmService =
      Get.find();

  sendMessageWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '${userModel.countryCode} ${userModel.phoneNumber}',
      text:
          '''*🚨 Agendamento realizado 🚨*
Sua solicitação foi confirmada com sucesso. Por favor, compareça no dia *${DateFormat('dd/MM/yyyy').format(schedulingPoliciaStationWomanModel.dateScheduling)}, às ${schedulingPoliciaStationWomanModel.timeScheduling},* no local abaixo:

📍Rua Arthur Bernardes, 932, centro, governador valadares
          
📍https://maps.app.goo.gl/wpwFjXtor93nQQuA7?g_st=iw''',
    );

    await launchUrl(link.asUri());
    Get.back();
  }

  Widget cripCopy({required String title, required String copy}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyleTheme.title,
        ),

        SizedBox(height: 5),

        Chip(
          deleteIcon: Icon(
            Icons.copy,
            size: 25,
          ),
          onDeleted: () {
            Clipboard.setData(
              ClipboardData(text: copy),
            );

            Get.snackbar(
              '',
              '',
              titleText: Text(
                'Texto copiado 📋',
                style: TextStyle(color: Colors.white),
              ),
              messageText: Text(
                'Basta colar na área indicada.',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            );
          },
          label: SizedBox(
            height: 40,
            child: Center(
              child: SelectableText(copy),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Dados para agendamento',
              style: AppTextStyleTheme.title,
            ),

            Spacer(),

            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),

        Text(
          'Data e Horário',
          style: AppTextStyleTheme.title,
        ),

        SizedBox(height: 5),

        Row(
          children: [
            Chip(
              label: Text(
                DateFormat(
                  'dd/MM/yyyy',
                ).format(
                  schedulingPoliciaStationWomanModel.dateScheduling,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(width: 10),
            Chip(
              label: Text(
                schedulingPoliciaStationWomanModel.timeScheduling,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        cripCopy(
          title: 'Endereço',
          copy: schedulingPoliciaStationWomanModel.address,
        ),

        SizedBox(height: 20),

        cripCopy(
          title: 'Nome',
          copy: userModel.name,
        ),

        SizedBox(height: 20),

        cripCopy(
          title: 'CPF',
          copy: userModel.cpf,
        ),

        SizedBox(height: 30),

        Card(
          elevation: 0,
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                Checkbox(
                  value: schedulingPoliciaStationWomanModel
                      .requestProtectiveMeasures,
                  onChanged: (value) {},
                ),

                Expanded(
                  child: Text(
                    'Solicitou uma medida protetiva nos últimos seis meses.',
                  ),
                ),
              ],
            ),
          ),
        ),

        Divider(height: 50),

        Text(
          'Dados para contato',
          style: AppTextStyleTheme.title,
        ),

        SizedBox(height: 10),

        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              userModel.profileImage,
            ),
          ),
          title: Text(
            userModel.name,
            style: AppTextStyleTheme.title,
          ),
        ),

        SizedBox(height: 10),

        InkWell(
          onTap: () {
            sendMessageWhatsApp();
          },
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            color: color.secondaryContainer,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(
                Icons.phone,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                userModel.phoneNumber,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),

        SizedBox(height: 10),

        InkWell(
          onTap: () {
            openEmail(email: userModel.email, message: 'message');
          },
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: 0,
            color: color.secondaryContainer,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(
                Icons.email,
                color: Colors.white,
                size: 30,
              ),
              title: FittedBox(
                alignment: AlignmentGeometry.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  userModel.email,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 50),

        Text(
          'Tente realizar o agendamento. Se for confirmado, envie um e-mail ou mensagem no WhatsApp e marque a opção como “Agendado”',
        ),

        SizedBox(height: 20),

        ButtonsComponent.buttonFilled(
          title: 'Agendado',
          function: () {
            schedulingPoliceWomanAdmService.updateItWasScheduled(
              docId: schedulingPoliciaStationWomanModel.docId!,
              itWasScheduled: true,
            );
          },
        ),

        SizedBox(height: 10),

        ButtonsComponent.buttonFilled(
          title: 'Não agendado',
          color: Colors.red,
          function: () {
            schedulingPoliceWomanAdmService.updateItWasScheduled(
              docId: schedulingPoliciaStationWomanModel.docId!,
              itWasScheduled: false,
            );
          },
        ),
      ],
    );
  }
}
