import 'package:eva/models/personal_network_model.dart';
import 'package:eva/models/user_model.dart';
import 'package:eva/services/files_service.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/services/user_service.dart';
import 'package:eva/utils/pick_image_util.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/components/show_list_personal_network_component.dart';
import 'package:eva/ux/components/show_loading_component.dart';
import 'package:eva/ux/screens/recording_audio/recording_audio_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ActionsService extends GetxController {
  dial190() async {
    showLoadingComponent();

    await launchUrl(Uri.parse("tel:190"));

    Get.back();
  }

  sendLocalizationWhatsapp() async {
    PersonalNetworkModel? personalNetworkModel =
        await ShowListPersonalNetworkComponent.showList();

    UserService userService = Get.find();

    UserModel userModel = userService.userModel.value!;

    if (personalNetworkModel != null) {
      // showLoadingComponent();
      bool update = await userService.updatingLocation();

      if (update == true) {
        final link = WhatsAppUnilink(
          phoneNumber:
              '${personalNetworkModel.countryCode} ${personalNetworkModel.phoneNumber}',
          text:
              '''*🚨 Alerta de emergência - Eva*
          
          Acionei o botão de emergência no app Eva e preciso da sua ajuda agora. Estou passando por um momento difícil.
         
          Por favor, tente entrar em contato comigo o mais rápido possível ou acione as autoridades, se necessário.

          *📍 Minha localização atual:* https://www.google.com/maps?q=${userModel.currentLocation!.latitude},${userModel.currentLocation!.longitude}
          ''',
        );

        await launchUrl(link.asUri());
        Get.back();
      }
    }
  }

  pickImageAndSave() async {
    HiveService hiveService = Get.find();
    FilesService filesService = Get.find();

    XFile? file = await pickImageUtil(cameraGrip: true);

    if (file != null) {
      filesService.listPathPhotographs.value.add(file.path);
      filesService.listPathPhotographs.update((val) {});

      hiveService.updateListPhotos(
        list: filesService.listPathPhotographs.value,
      );

      feedback();
    }
  }

  pickVideoAndSave() async {
    HiveService hiveService = Get.find();
    FilesService filesService = Get.find();

    XFile? file = await pickVideoUtil();

    if (file != null) {
      Map<String, dynamic> map = {
        'date': DateTime.now().toIso8601String(),
        'path': file.path,
      };

      filesService.listPathVideo.value.add(map);

      filesService.listPathVideo.update((val) {});

      hiveService.updateListVideos(
        list: filesService.listPathVideo.value,
      );

      feedback();
    }
  }

  recordAudio() {
    Get.to(() => RecordingAudioScreen());
  }

  feedback() {
    FeedbackComponent.successfulAction(
      message: 'Arquivo salvo com sucesso na galeria do app.',
      durationSeconds: 6,
    );
  }
}
