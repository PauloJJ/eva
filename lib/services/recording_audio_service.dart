import 'dart:async';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:eva/services/files_service.dart';
import 'package:eva/services/hive_service.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/components/show_loading_component.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordingAudioService extends GetxController {
  final record = AudioRecorder();
  Timer? timer;

  Duration duration = Duration.zero;
  RxString timerString = '00:00'.obs;

  @override
  void onInit() {
    initRecording();
    super.onInit();
  }

  @override
  void onClose() {
    record.dispose();

    timer?.cancel();
    super.onClose();
  }

  initRecording() async {
    final status = await record.hasPermission();

    if (status == true) {
      final directory = await getApplicationDocumentsDirectory();

      await record.start(
        path: '${directory.path}/${Random().nextDouble()}.wav',

        RecordConfig(
          encoder: AudioEncoder.wav,
          bitRate: 32000,
          numChannels: 1,
        ),
      );

      initTimer();
    } else {
      Get.back();

      FeedbackComponent.confirmationAction(
        content:
            'Precisamos de acesso ao seu microfone para gravar áudio. Acesse as configurações e permita o uso para continuar.',
        function: () async {
          showLoadingComponent();

          await AppSettings.openAppSettings(type: AppSettingsType.settings);
          Get.back();
          Get.back();
        },
      );
    }
  }

  saveAudio() async {
    Get.closeAllSnackbars();

    showLoadingComponent();

    String? path = await record.stop();

    if (path != null) {
      FilesService filesService = Get.find();
      HiveService hiveService = Get.find();

      Map<String, dynamic> map = {
        'path': path,
        'date': DateTime.now().toIso8601String(),
        'audioTimer': timerString.value,
      };

      filesService.listPathAudio.value.add(map);
      filesService.listPathAudio.update((val) {});

      await hiveService.updateListAudio(
        list: filesService.listPathAudio.value,
      );
    }

    Get.back();
    Get.back();

    FeedbackComponent.successfulAction(
      message:
          'Áudio salvo com sucesso. Você pode acessá-lo na área de arquivos.',
    );
  }

  initTimer() async {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        duration += Duration(seconds: 1);

        timerString.value =
            '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
      },
    );
  }
}
