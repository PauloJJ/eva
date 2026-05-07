import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RemoveOrAddCandidatureFairyGodmontherService extends GetxController {
  final formKey = GlobalKey<FormState>();

  List<String> filterlist = [
    'Psicóloga',
    'Advogada',
    'Assistente Social',
    'Voluntárias de apoio',
  ];

  RxString categorySelect = ''.obs;

  RxBool isLoading = false.obs;

  selectCategory(String category) {
    if (categorySelect.value == category) {
      categorySelect.value = '';
    } else {
      categorySelect.value = category;
    }
  }

  appliedToBeAFairygodmother({
    required String email,
    required String number,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (categorySelect.value.isEmpty) {
      FeedbackComponent.definitiveError(
        message: 'Selecione a categoria para continuar.',
      );
      return;
    }

    isLoading.value = true;

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'professionFairyGodmonther': categorySelect.value,
        'volunteerFairyGodmonther': true,

        'numberVolunteer': number,
        'emailVolunteer': email,
      });

      Get.back();

      FeedbackComponent.successfulAction(
        message: 'Candidatura realizada com sucesso.',
      );
    } catch (_) {
      Get.back();
      isLoading.value = false;

      FeedbackComponent.definitiveError(
        message: 'Algo deu errado. Tente novamente.',
      );
    }
  }

  removeCandidatureFairyGodmonther() async {
    isLoading.value = true;

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'professionFairyGodmonther': null,
        'volunteerFairyGodmonther': false,
      });

      Get.back();

      FeedbackComponent.successfulAction(
        message: 'Candidatura realizada com sucesso.',
      );
    } catch (_) {
      Get.back();
      isLoading.value = false;

      FeedbackComponent.definitiveError(
        message: 'Algo deu errado. Tente novamente.',
      );
    }
  }
}
