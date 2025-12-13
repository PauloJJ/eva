import 'package:eva/models/user_model.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/utils/format_text_util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class ActionsSosService extends GetxController {
  TwilioFlutter? twilioFlutter;

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
    await initTwilioModel();
    initSos();

    super.onInit();
  }

  initTwilioModel() async {
    final mapEnv = dotenv.env;

    String accountSid = mapEnv['ACCOUNTSID']!;
    String authToken = mapEnv['AUTHTOKEN']!;
    String twilioNumber = mapEnv['TWILIONUMBER']!;

    twilioFlutter = TwilioFlutter(
      accountSid: accountSid,
      authToken: authToken,
      twilioNumber: twilioNumber,
    );
  }

  initSos() async {
    bool updatedLocation = await getCurrentLocation();

    if (updatedLocation == true) {
      // sendSms();
    }
  }

  sendSms() async {
    UserModel userModel = userService.userModel.value!;

    final teste = await twilioFlutter!.sendSMS(
      toNumber: '+5521966841107',
      messageBody:
          '${FormatTextsUtil.replaceRange(userModel.name)} Precia da sua ajuda!\n',
    );

    print('===================== ${teste.responseCode}');
    print('===================== ${teste.errorData}');
    print('===================== ${teste.responseState.name}');
  }

  sendEmails() {}

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
