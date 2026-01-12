import 'package:eva/services/scheduling_police_station_woman_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/screens/scheduling_police_station_woman/widgets/scheduling_requests_widget.dart';
import 'package:eva/ux/screens/scheduling_police_station_woman/widgets/to_schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchedulingAndAppointmentsWidget extends StatelessWidget {
  SchedulingAndAppointmentsWidget({super.key});

  final SchedulingPoliceStationWomanService
  schedulingPoliceStationWomanService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        String optionSelect =
            schedulingPoliceStationWomanService.optionSelect.value;

        return Scaffold(
          appBar: AppBar(
            actionsPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text('Agendamentos & Solicitações'),
            actions: [
              IconButton(
                onPressed: () {
                  schedulingPoliceStationWomanService.showInformations();
                },
                icon: Icon(
                  Icons.help_outline,
                  size: 30,
                  color: color.primary,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<String>(
                      segments: schedulingPoliceStationWomanService
                          .listOptionButton
                          .map(
                            (e) => ButtonSegment(
                              value: e,
                              label: SizedBox(
                                width: size.width,
                                child: SizedBox(
                                  height: 45,
                                  child: Center(
                                    child: FittedBox(
                                      child: Text(
                                        e,
                                        style: AppTextStyleTheme.title,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      selected: {
                        schedulingPoliceStationWomanService.optionSelect.value,
                      },
                      onSelectionChanged: (value) {
                        schedulingPoliceStationWomanService.optionSelect.value =
                            value.first;
                      },
                    ),

                    SizedBox(height: 20),

                    if (optionSelect == 'Agendar') ToScheduleWidget(),

                    if (optionSelect == 'Agendamentos')
                      SchedulingRequestsWidget(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
