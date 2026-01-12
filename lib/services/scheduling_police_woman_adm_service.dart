import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/scheduling_policia_station_woman_model.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/utils/same_day_util.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/components/show_loading_component.dart';
import 'package:eva/ux_adm/screens/home_adm/scheduling_police_woman_adm/widgets/schedule_or_reject_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchedulingPoliceWomanAdmService extends GetxController {
  Rx<List<SchedulingPoliciaStationWomanModel>> listScheduling = Rx([]);
  Rx<List<SchedulingPoliciaStationWomanModel>> listSchedulingDuplicated = Rx(
    [],
  );

  List<String> listOptions = ['Solicitações', 'Agendados/Recusados'];

  RxString optionSelect = 'Solicitações'.obs;

  RxBool requestsToday = false.obs;

  @override
  void onInit() {
    super.onInit();

    listScheduling.bindStream(streamSchedulin());
  }

  Stream<List<SchedulingPoliciaStationWomanModel>> streamSchedulin() async* {
    final snapshot = FirebaseFirestore.instance
        .collection('schedulingPoliceStationWoman')
        .snapshots();

    await for (var e in snapshot) {
      List<SchedulingPoliciaStationWomanModel>
      schedulingPoliciaStationWomanModel = e.docs.map((doc) {
        final model = SchedulingPoliciaStationWomanModel.fromJson(doc.data());

        model.docId = doc.id;

        return model;
      }).toList();

      schedulingPoliciaStationWomanModel.sort(
        (a, b) {
          return a.dateScheduling.compareTo(b.dateScheduling);
        },
      );

      listSchedulingDuplicated.value = schedulingPoliciaStationWomanModel;

      final listFilter = filterSelect();

      yield listFilter;
    }
  }

  scheduleOrReject(
    SchedulingPoliciaStationWomanModel schedulingPoliciaStationWomanModel,
  ) async {
    showLoadingComponent();

    final user = await FirebaseFirestore.instance
        .collection('users')
        .doc(schedulingPoliciaStationWomanModel.userId)
        .get();

    UserModel userModel = UserModel.fromJson(user.data()!);

    Get.back();

    showDialog(
      context: Get.context!,

      builder: (context) {
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(15),
          content: ScheduleOrRejectWidget(
            schedulingPoliciaStationWomanModel:
                schedulingPoliciaStationWomanModel,
            userModel: userModel,
          ),
        );
      },
    );
  }

  updateItWasScheduled({
    required String docId,
    required bool itWasScheduled,
  }) async {
    showLoadingComponent();

    try {
      await FirebaseFirestore.instance
          .collection('schedulingPoliceStationWoman')
          .doc(docId)
          .update({'itWasScheduled': itWasScheduled});
      Get.back();
      Get.back();

      FeedbackComponent.showInformation('Agendamento realizado com sucesso.');
    } catch (_) {
      Get.back();
      FeedbackComponent.showErrorDefinitive(
        content: 'Algo deu errado. Tente novamente.',
      );
    }
  }

  List<SchedulingPoliciaStationWomanModel> filterSelect() {
    List<SchedulingPoliciaStationWomanModel> list = [];

    if (optionSelect.value == 'Solicitações') {
      list = listSchedulingDuplicated.value.where(
        (element) {
          return element.itWasScheduled == null ? true : false;
        },
      ).toList();
    } else {
      list = listSchedulingDuplicated.value.where(
        (element) {
          return (element.itWasScheduled == true ||
                  element.itWasScheduled == false)
              ? true
              : false;
        },
      ).toList();
    }

    if (requestsToday.value == true) {
      list = filterToday();
    }

    return list;
  }

  List<SchedulingPoliciaStationWomanModel> filterToday() {
    final dateNow = DateTime.now();

    return listSchedulingDuplicated.value.where(
      (element) {
        return sameday(a: dateNow, b: element.dateScheduling);
      },
    ).toList();
  }
}
