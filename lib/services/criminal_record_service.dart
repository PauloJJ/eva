import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:eva/models/result_criminal_record_model.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/admob_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CriminalRecordService extends GetxController {
  final formKey = GlobalKey<FormState>();

  Rx<ResultCriminalRecordModel?> resultCriminalRecordModel = Rx(null);

  RxBool isLoading = false.obs;

  getCriminalRecords({
    required String userCpf,
    required String name,
    required String dateOfBirth,
    required String cpf,
    required String mothersName,
    required String fathersName,
  }) async {
    AdmobService admobService = Get.find<AdmobService>();
    UserService userService = Get.find<UserService>();

    UserModel userModel = userService.userModel.value!;

    if (userModel.lastConsultCriminalRecord != null) {
      String lastConsultCriminalRecordFormated = DateFormat(
        'dd/MM/yyyy',
      ).format(userModel.lastConsultCriminalRecord!);

      String dateNowFormated = DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.timestamp());

      if (lastConsultCriminalRecordFormated == dateNowFormated) {
        FeedbackComponent.definitiveError(
          message:
              'Você já utilizou sua consulta gratuita hoje. Tente novamente amanhã.',
        );
        return null;
      }
    }

    if (!formKey.currentState!.validate()) {
      return null;
    }

    final dateFormat = DateFormat('dd/MM/yyyy').parse(dateOfBirth);
    dateOfBirth = DateFormat('yyyy-MM-dd').format(dateFormat);
    userCpf = userCpf.replaceAll(RegExp(r'[-.]'), '');
    cpf = cpf.replaceAll(RegExp(r'[-.]'), '');

    isLoading.value = true;

    await admobService.loadAndShowOpenAppAd();

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'lastConsultCriminalRecord': DateTime.timestamp(),
      });
    } catch (_) {
      FeedbackComponent.showErrorDefinitive(
        content: 'Algo deu errado. Tente novamente.',
      );

      return;
    }

    final reponse = await FirebaseFunctions.instance
        .httpsCallable('consultApiGov')
        .call({
          'userCpf': userCpf,
          'name': name,
          'dateOfBirth': dateOfBirth,
          'cpf': cpf,
          'mothersName': mothersName,
          'fathersName': fathersName,
        });

    isLoading.value = false;

    if (reponse.data['status'] != 200) {
      FeedbackComponent.showErrorDefinitive(
        content: 'Algo deu errado. Tente novamente.',
      );

      return;
    }

    resultCriminalRecordModel.value = ResultCriminalRecordModel.fromJson(
      reponse.data,
    );
  }
}
