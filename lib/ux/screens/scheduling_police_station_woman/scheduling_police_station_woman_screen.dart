import 'package:eva/services/hive_service.dart';
import 'package:eva/services/scheduling_police_station_woman_service.dart';
import 'package:eva/ux/screens/scheduling_police_station_woman/widgets/scheduling_and_appointments_widget.dart';
import 'package:eva/ux/screens/scheduling_police_station_woman/widgets/welcome_scheduling_police_woman_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

class SchedulingPoliceStationWomanScreen extends StatelessWidget {
  SchedulingPoliceStationWomanScreen({super.key});

  final SchedulingPoliceStationWomanService
  schedulingPoliceStationWomanService = Get.put(
    SchedulingPoliceStationWomanService(),
  );

  final HiveService hiveService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (hiveService.firstSchedulingPolice.value == true) {
          return WelcomeSchedulingPoliceWomanWidget();
        } else {
          return SchedulingAndAppointmentsWidget();
        }
      },
    );
  }
}
