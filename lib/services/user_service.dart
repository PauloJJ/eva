import 'dart:io';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/personal_network_model.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/utils/pick_image_util.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/components/show_loading_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<bool> updatingLocation() async {
    bool updatedLocation = false;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (serviceEnabled == false) {
      FeedbackComponent.definitiveError(
        message: 'Ative a localização e permita que a Eva te proteja melhor.',
        durationSeconds: 5,
      );

      return updatedLocation;
    }

    LocationPermission locationPermission =
        await Geolocator.requestPermission();

    if (locationPermission == LocationPermission.denied) {
      FeedbackComponent.definitiveError(
        message: 'Precisamos da sua permissão para continuar com segurança',
        durationSeconds: 5,
      );
    }

    if (locationPermission == LocationPermission.deniedForever) {
      await FeedbackComponent.alertConfirmation(
        content:
            'Precisamos que você acesse as configurações do app e permita manualmente o acesso da Eva à sua localização.',
        function: () {
          AppSettings.openAppSettings(type: AppSettingsType.settings);
          Get.back();
        },
      );
    }

    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final currentLocation = await Geolocator.getCurrentPosition();

      try {
        await FirebaseFirestore.instance.collection('users').doc(userId).update(
          {
            'currentLocation': GeoPoint(
              currentLocation.latitude,
              currentLocation.longitude,
            ),
          },
        );

        updatedLocation = true;
      } catch (_) {
        FeedbackComponent.definitiveError(
          message: 'A localização não pôde ser atualizada. Tente novamente.',
        );
      }
    }

    return updatedLocation;
  }

  updateDatas({
    required String name,
    required String phoneNumber,
    required String selectedCountry,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showLoadingComponent();

    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': name,
        'phoneNumber': phoneNumber,
        'countryCode': selectedCountry,
      });

      Get.back();
      Get.back();

      FeedbackComponent.successfulAction(
        message: 'Informações atualizadas com sucesso.',
      );
    } catch (_) {
      Get.back();

      FeedbackComponent.definitiveError(
        message: 'Erro ao atualizar as informações. Tente novamente.',
      );
    }
  }

  updatePhoto() async {
    showLoadingComponent();

    XFile? image = await pickImageUtil(cameraGrip: false);

    if (image != null) {
      final path = 'imagesPersonalNetwork/${Random().nextDouble()}';

      final ref = FirebaseStorage.instance.ref().child(path);

      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();

      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profileImage': url,
      });

      Get.back();
    }
  }
}
