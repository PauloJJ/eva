import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:eva/models/personal_network_model.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/utils/format_text_util.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ActionsSosService extends GetxController {
  UserService userService = Get.find();

  Rx<List<Map<String, dynamic>>> listSucceded = Rx([
    {
      'title': 'Localização atualizada',
      'successfulAction': false,
    },
    {
      'title': 'SMS enviado',
      'successfulAction': false,
    },
    {
      'title': 'E-mail enviado',
      'successfulAction': false,
    },
  ]);

  @override
  void onInit() async {
    initSos();

    super.onInit();
  }

  initSos() async {
    bool updatedLocation = await getCurrentLocation();

    if (updatedLocation == true) {
      await Future.wait([
        sendSms(),
        sendEmails(),
      ]);

      FeedbackComponent.successfulAction(
        message: 'Dados enviados com sucesso para sua rede de apoio.',
      );
    }

    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'lastSosActivated': DateTime.timestamp(),
    });
  }

  Future<void> sendSms() async {
    UserModel userModel = userService.userModel.value!;

    List<PersonalNetworkModel> listPersonalNetworkModel =
        userService.listPersonalNetworkModel.value;

    List<String> listNumbers = [];

    Iterable<String> list = listPersonalNetworkModel.map(
      (e) =>
          '${e.countryCode}${e.phoneNumber.replaceAll(RegExp(r'[^\d]'), '')}',
    );

    listNumbers.addAll(list);

    try {
      await FirebaseFunctions.instance.httpsCallable('sendSms').call([
        {
          "numbers": listNumbers,
          "userName": userModel.name,
          "latitude": userModel.currentLocation!.latitude.toString(),
          "longitude": userModel.currentLocation!.longitude.toString(),
        },
      ]);
    } catch (_) {
      FeedbackComponent.definitiveError(
        message: 'Não foi possível enviar o SMS no momento.',
      );
    }

    listSucceded.value[1]['successfulAction'] = true;
    listSucceded.update((val) {});
  }

  Future<void> sendEmails() async {
    UserModel userModel = userService.userModel.value!;

    List<PersonalNetworkModel> listPersonalNetworkModel =
        userService.listPersonalNetworkModel.value;

    List<String> listEmail = listPersonalNetworkModel
        .map((e) => e.email)
        .toList();

    if (listEmail.isNotEmpty) {
      try {
        await FirebaseFunctions.instance.httpsCallable('sendEmail').call([
          {
            'listEmail': listEmail,
            'userName': FormatTextsUtil.replaceRange(userModel.name),
            'linkMapa':
                'https://www.google.com/maps?q=${userModel.currentLocation!.latitude},${userModel.currentLocation!.longitude}',
          },
        ]);
      } catch (_) {
        FeedbackComponent.definitiveError(
          message: 'Não foi possível enviar os E-mail no momento.',
        );
      }

      listSucceded.value[2]['successfulAction'] = true;
      listSucceded.update((val) {});
    }
  }

  Future<bool> getCurrentLocation() async {
    bool updated = await userService.updatingLocation();

    if (updated == true) {
      listSucceded.value[0]['successfulAction'] = true;
      listSucceded.update((val) {});
    } else {
      Get.back();
      Get.back();
    }

    return updated;
  }
}
