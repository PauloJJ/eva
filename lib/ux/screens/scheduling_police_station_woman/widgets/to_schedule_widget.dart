import 'package:eva/services/scheduling_police_station_woman_service.dart';
import 'package:eva/themes/app_text_style_theme.dart';
import 'package:eva/utils/utils_general.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ToScheduleWidget extends StatelessWidget {
  ToScheduleWidget({super.key});

  final SchedulingPoliceStationWomanService
  schedulingPoliceStationWomanService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<String> listOfAvailableTimes =
            schedulingPoliceStationWomanService.listOfAvailableTimes.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(15),
              child: TableCalendar(
                locale: 'pt_BR',
                focusedDay: DateTime.timestamp(),
                firstDay: DateTime.timestamp(),
                lastDay: DateTime(2090),
                currentDay:
                    schedulingPoliceStationWomanService.currentDay.value,
                enabledDayPredicate: (day) {
                  return day.weekday != DateTime.saturday &&
                      day.weekday != DateTime.sunday;
                },
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  schedulingPoliceStationWomanService.currentDay.value =
                      selectedDay;
                },
              ),
            ),
            SizedBox(height: 40),

            Text(
              'Horários disponíveis',
              style: AppTextStyleTheme.title,
            ),

            SizedBox(height: 15),

            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 50,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: listOfAvailableTimes.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Obx(
                  () {
                    bool availableSchedule = schedulingPoliceStationWomanService
                        .checkAvailableAppointments(
                          listOfAvailableTimes[index],
                        );

                    return InkWell(
                      onTap: availableSchedule == false
                          ? null
                          : () {
                              bool requestedAnAppointmentToday =
                                  schedulingPoliceStationWomanService
                                      .requestedAnAppointmentToday();

                              if (requestedAnAppointmentToday == true) {
                                FeedbackComponent.definitiveError(
                                  message:
                                      'Você só pode solicitar um agendamento por dia.',
                                );
                              } else {
                                schedulingPoliceStationWomanService
                                    .showConfirmAppointment(
                                      listOfAvailableTimes[index],
                                    );
                              }
                            },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: color.primary),
                          color: availableSchedule == false ? Colors.red : null,
                        ),
                        child: Center(
                          child: Text(
                            listOfAvailableTimes[index],
                            style: AppTextStyleTheme.title.apply(
                              color: availableSchedule == false
                                  ? Colors.white
                                  : color.primary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
