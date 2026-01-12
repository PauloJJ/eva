import 'package:eva/models/scheduling_policia_station_woman_model.dart';
import 'package:eva/services/scheduling_police_woman_adm_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SchedulingPoliceWomanAdmScreen extends StatelessWidget {
  SchedulingPoliceWomanAdmScreen({super.key});

  final SchedulingPoliceWomanAdmService schedulingPoliceWomanAdmService =
      Get.put(SchedulingPoliceWomanAdmService());

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
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text('Soliciatações e Agendamentos'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 20),

                  SizedBox(
                    width: size.width,
                    child: SegmentedButton<String>(
                      segments: schedulingPoliceWomanAdmService.listOptions
                          .map(
                            (e) => ButtonSegment(
                              value: e,
                              label: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5,
                                ),
                                child: Text(
                                  e,
                                  style: AppTextStyleTheme.title,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onSelectionChanged: (value) {
                        schedulingPoliceWomanAdmService.optionSelect.value =
                            value.first;

                        schedulingPoliceWomanAdmService.requestsToday.value =
                            false;

                        schedulingPoliceWomanAdmService.listScheduling.value =
                            schedulingPoliceWomanAdmService.filterSelect();
                      },
                      selected: {
                        schedulingPoliceWomanAdmService.optionSelect.value,
                      },
                    ),
                  ),

                  if (schedulingPoliceWomanAdmService.optionSelect.value ==
                      'Solicitações') ...[
                    SizedBox(height: 20),

                    FilterChip(
                      selected:
                          schedulingPoliceWomanAdmService.requestsToday.value,
                      label: SizedBox(
                        height: 30,
                        width: size.width,
                        child: Center(
                          child: Text('Solicitações para hoje'),
                        ),
                      ),
                      onSelected: (value) {
                        schedulingPoliceWomanAdmService.requestsToday.value =
                            value;

                        schedulingPoliceWomanAdmService.listScheduling.value =
                            schedulingPoliceWomanAdmService.filterSelect();
                      },
                    ),
                  ],

                  SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: schedulingPoliceWomanAdmService
                          .listScheduling
                          .value
                          .length,

                      itemBuilder: (context, index) {
                        SchedulingPoliciaStationWomanModel
                        schedulingPoliciaStationWomanModel =
                            schedulingPoliceWomanAdmService
                                .listScheduling
                                .value[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              schedulingPoliceWomanAdmService.scheduleOrReject(
                                schedulingPoliciaStationWomanModel,
                              );
                            },
                            child: Card(
                              color: color.secondary,
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: color.primary,
                                          ),
                                          child: Icon(
                                            Icons.date_range_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat(
                                                'dd/MM/yyyy',
                                              ).format(
                                                schedulingPoliciaStationWomanModel
                                                    .dateScheduling,
                                              ),
                                              style: AppTextStyleTheme.title,
                                            ),

                                            SizedBox(height: 5),

                                            Text(
                                              schedulingPoliciaStationWomanModel
                                                  .timeScheduling,
                                              style: AppTextStyleTheme.title,
                                            ),

                                            SizedBox(height: 10),

                                            cardInformation(
                                              schedulingPoliciaStationWomanModel
                                                  .itWasScheduled,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
