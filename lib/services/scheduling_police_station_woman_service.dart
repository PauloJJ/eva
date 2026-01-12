import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/scheduling_policia_station_woman_model.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/screens/scheduling_police_station_woman/widgets/confirm_scheduling_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SchedulingPoliceStationWomanService extends GetxController {
  final addressController = TextEditingController();

  Rx<List<String>> listOfAvailableTimes = Rx([
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ]);

  Rx<DateTime> currentDay = Rx(
    DateTime.timestamp(),
  );

  RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  RxBool requestedInTheLastSixMonths = false.obs;

  Rx<List<SchedulingPoliciaStationWomanModel>> listSchedulin = Rx([]);

  List<String> listOptionButton = ['Agendamentos', 'Agendar'];
  RxString optionSelect = 'Agendamentos'.obs;

  @override
  void onInit() {
    super.onInit();

    updateWelcomeSchedulingPolice();

    listSchedulin.bindStream(streamSchedulin());
  }

  updateWelcomeSchedulingPolice() {
    HiveService hiveService = Get.find();
    hiveService.updateFirstWelcomeSchedulingPolice();
  }

  toggleCheckBox(bool value) {
    requestedInTheLastSixMonths.value = value;
  }

  showConfirmAppointment(String schedulingTime) {
    Get.to(
      () => ShowConfirmSchedulingWidget(
        dateScheduling: currentDay.value,
        schedulingTime: schedulingTime,
      ),
    );
  }

  registerScheduling(String timeScheduling) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      await FirebaseFirestore.instance
          .collection('schedulingPoliceStationWoman')
          .doc()
          .set(
            SchedulingPoliciaStationWomanModel(
              userId: userId,
              timeScheduling: timeScheduling,
              dateScheduling: currentDay.value,
              requestDate: DateTime.timestamp(),
              requestProtectiveMeasures: requestedInTheLastSixMonths.value,
              address: addressController.text,
              itWasScheduled: null,
            ).toJson(),
          );

      resetData();

      Get.back();

      FeedbackComponent.successfulAction(
        durationSeconds: 6,
        message: 'Solicitação enviada com sucesso.',
      );
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<SchedulingPoliciaStationWomanModel>> streamSchedulin() async* {
    final snapshot = FirebaseFirestore.instance
        .collection('schedulingPoliceStationWoman')
        .snapshots();

    await for (var e in snapshot) {
      List<SchedulingPoliciaStationWomanModel>
      schedulingPoliciaStationWomanModel = e.docs
          .map((e) => SchedulingPoliciaStationWomanModel.fromJson(e.data()))
          .toList();

      yield schedulingPoliciaStationWomanModel;
    }
  }

  resetData() {
    requestedInTheLastSixMonths.value = false;
    addressController.clear();
  }

  bool checkAvailableAppointments(String timer) {
    final hasAppointment = listSchedulin.value.any((element) {
      return element.timeScheduling == timer &&
          sameDay(
            dateA: element.dateScheduling.toUtc(),
            dateB: currentDay.value,
          );
    });

    return !hasAppointment; // true = disponível | false = ocupado
  }

  bool requestedAnAppointmentToday() {
    final dateNow = DateTime.timestamp();

    final userId = FirebaseAuth.instance.currentUser!.uid;

    bool requested = listSchedulin.value.any(
      (element) {
        return sameDay(dateA: dateNow, dateB: element.requestDate.toUtc()) &&
            element.userId == userId;
      },
    );

    return requested;
  }

  bool sameDay({required DateTime dateA, required DateTime dateB}) {
    return dateA.day == dateB.day &&
        dateA.month == dateB.month &&
        dateA.year == dateB.year;
  }

  showInformations() {
    FeedbackComponent.showInformation(
      '''01 - Escolha do dia No aplicativo, você seleciona o dia em que deseja ser atendida.

02- Envio da solicitação Assim que você confirmar o dia, o aplicativo envia sua solicitação para o administrador. Ele utilizará os dados já cadastrados na sua conta (nome, CPF, e-mail etc.) para tentar realizar o agendamento oficial no sistema deles.

03 - Análise do administrador O administrador verifica se há vaga no dia escolhido e tenta concluir o agendamento.

04- Retorno para você Após a tentativa, você receberá uma resposta de duas formas:

Se o agendamento for confirmado:
Você receberá um e-mail ou uma menssagem no Whatsapp de confirmação.
No aplicativo, o status aparecerá como “Agendado”.

Se o agendamento não puder ser realizado:
Você receberá um e-mail informando que não foi possível agendar.
No aplicativo, o status aparecerá como “Não agendado”''',
    );
  }
}
