import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/ux/screens/fairy_godmothers/widgets/show_datas_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FairyGodmonthersService extends GetxController {
  Rx<List<UserModel>> listFairyGodmonthers = Rx([]);

  List<String> filterlist = [
    'Psicóloga',
    'Advogada',
    'Assistente Social',
    'Voluntárias de apoio',
  ];

  RxString categorySelect = ''.obs;

  @override
  void onInit() {
    listFairyGodmonthers.bindStream(streamListFairyGodmonthers());
    super.onInit();
  }

  Stream<List<UserModel>> streamListFairyGodmonthers() async* {
    final snapshots = FirebaseFirestore.instance
        .collection('users')
        .where('volunteerFairyGodmonther', isEqualTo: true)
        .snapshots();

    await for (var e in snapshots) {
      final listUser = e.docs.map((e) => UserModel.fromJson(e.data())).toList();

      yield listUser;
    }
  }

  selectCategory(String category) {
    if (categorySelect.value == category) {
      categorySelect.value = '';
    } else {
      categorySelect.value = category;
    }
  }

  showDatasUser(UserModel userModel) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Dados para Contato'),
          content: ShowDatasUserWidget(userModel: userModel),
        );
      },
    );
  }

  searchFairyGodmonthers() {}
}
