import 'package:eva/models/scheduling_policia_station_woman_model.dart';
import 'package:eva/services/scheduling_police_station_woman_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/open_url_and_email_util.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/buttons_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SchedulingRequestsWidget extends StatelessWidget {
  SchedulingRequestsWidget({super.key});

  final SchedulingPoliceStationWomanService
  schedulingPoliceStationWomanService = Get.find();

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Widget cardInformation(bool? timeScheduling) {
    Color colorCard = timeScheduling == true
        ? Colors.green
        : timeScheduling == false
        ? Colors.red
        : Colors.grey.shade300;

    Color textColor = (timeScheduling == true || timeScheduling == false)
        ? Colors.white
        : Colors.black;

    String title = timeScheduling == true
        ? 'Agendado'
        : timeScheduling == false
        ? 'Não agendado'
        : 'Pendente';

    return Card(
      color: colorCard,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  appointmentConfirmed() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Seu horário foi agendado com sucesso!',
            textAlign: TextAlign.center,
            style: AppTextStyleTheme.title,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Basta comparecer à Delegacia da Mulher no horário escolhido, levando seu documento pessoal',
                textAlign: TextAlign.center,
                style: AppTextStyleTheme.subTitle,
              ),

              SizedBox(height: 20),

              ButtonsComponent.buttonOutline(
                title: 'Localização',
                icon: Icons.location_on_outlined,
                function: () {
                  openUrlUtil(
                    'https://maps.app.goo.gl/wpwFjXtor93nQQuA7?g_st=iw',
                  );
                },
              ),
            ],
          ),
          actions: [
            ButtonsComponent.buttonFilled(
              title: 'Voltar',
              function: () {},
            ),
          ],
        );
      },
    );
  }

  bool documentExists() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    bool exists = schedulingPoliceStationWomanService.listSchedulin.value.any(
      (element) {
        return element.userId == userId;
      },
    );

    return exists;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (documentExists() == true) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount:
                schedulingPoliceStationWomanService.listSchedulin.value.length,
            itemBuilder: (context, index) {
              SchedulingPoliciaStationWomanModel
              schedulingPoliciaStationWomanModel =
                  schedulingPoliceStationWomanService
                      .listSchedulin
                      .value[index];

              if (schedulingPoliciaStationWomanModel.userId == userId) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (schedulingPoliciaStationWomanModel.itWasScheduled ==
                            false ||
                        schedulingPoliciaStationWomanModel.itWasScheduled ==
                            null) {
                      schedulingPoliceStationWomanService.showInformations();
                    } else {
                      appointmentConfirmed();
                    }
                  },
                  child: Card(
                    color: color.secondary,
                    elevation: 0,
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      leading: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: color.primary,
                        ),
                        child: Icon(
                          Icons.date_range_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        DateFormat(
                          'dd/MM/yyyy',
                        ).format(
                          schedulingPoliciaStationWomanModel.dateScheduling,
                        ),
                      ),
                      subtitle: Text(
                        schedulingPoliciaStationWomanModel.timeScheduling,
                      ),
                      trailing: cardInformation(
                        schedulingPoliciaStationWomanModel.itWasScheduled,
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
       
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Text(
                'Nenhum agendamento\nrealizado',
                textAlign: TextAlign.center,
                style: AppTextStyleTheme.h3.apply(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
