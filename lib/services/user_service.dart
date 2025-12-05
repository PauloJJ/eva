import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/personal_network_model.dart';
import 'package:eva/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService extends GetxController {
  Rx<UserModel?> userModel = Rx(null);
  Rx<List<PersonalNetworkModel>> listPersonalNetworkModel = Rx([]);

  @override
  void onInit() {
    verifyingUserOnline();
    super.onInit();
  }

  verifyingUserOnline() {
    final user = FirebaseAuth.instance.authStateChanges();

    user.listen(
      (event) {
        if (event == null) {
          userModel.value = null;
        } else {
          userModel.bindStream(streamUser(event.uid));
          listPersonalNetworkModel.bindStream(streamPersonalNetwork(event.uid));
        }
      },
    );
  }

  Stream<UserModel> streamUser(String userId) async* {
    final snapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();

    await for (var e in snapshot) {
      UserModel user = UserModel.fromJson(e.data()!);

      yield user;
    }
  }

  Stream<List<PersonalNetworkModel>> streamPersonalNetwork(
    String userId,
  ) async* {
    final snapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('personalNetwork')
        .snapshots();

    await for (var e in snapshot) {
      List<PersonalNetworkModel> list = [];

      for (var e in e.docs) {
        PersonalNetworkModel personalNetworkModel =
            PersonalNetworkModel.fromJson(e.data());

        personalNetworkModel.docId = e.id;

        list.add(personalNetworkModel);
      }

      yield list;
    }
  }
}
