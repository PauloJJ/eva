import 'dart:io';
import 'package:eva/services/hive_service.dart';
import 'package:eva/ux/components/feedback_component.dart';
import 'package:eva/ux/components/show_loading_component.dart';
import 'package:eva/ux/screens/audio_player/audio_player_screen.dart';
import 'package:eva/ux/screens/files_audios/files_audios_screen.dart';
import 'package:eva/ux/screens/files_photographs/files_photographs_screen.dart';
import 'package:eva/ux/screens/files_videos/files_videos_screen.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

class FilesService extends GetxController {
  @override
  void onInit() {
    getLists();
    super.onInit();
  }

  Rx<List<String>> listPathPhotographs = Rx([]);
  Rx<List<Map<String, dynamic>>> listPathVideo = Rx([]);
  Rx<List<Map<String, dynamic>>> listPathAudio = Rx([]);

  getLists() async {
    HiveService hiveService = Get.find();

    listPathPhotographs.value = await hiveService.getListPhotos();
    listPathVideo.value = await hiveService.getListVideo();
    listPathAudio.value = await hiveService.getLisAudio();
  }

  navigatorFileScreen({
    required String filePath,
    required int index,
    required String listName,
  }) async {
    final file = File(filePath);

    showLoadingComponent();

    final bool exist = await file.exists();

    if (exist == true) {
      Get.back();

      if (listName == 'photographs') {
        Get.to(() => FilesPhotographsScreen());
        openFile(path: filePath, index: index, listName: listName);
      } else if (listName == 'video') {
        Get.to(() => FilesVideosScreen());
        openFile(path: filePath, index: index, listName: listName);
      } else {
        Get.to(() => FilesAudiosScreen());
        Get.to(() => AudioPlayerScreen(path: filePath));
      }
    } else {
      Get.back();

      FeedbackComponent.definitiveError(message: 'Arquivo não encontrado.');
      deleFile(listName: listName, index: index);
    }
  }

  deleFile({required String listName, required int index}) async {
    HiveService hiveService = Get.find();

    if (listName == 'photographs') {
      listPathPhotographs.value.removeAt(index);
      hiveService.updateListPhotos(list: listPathPhotographs.value);
    } else if (listName == 'video') {
      listPathVideo.value.removeAt(index);
      hiveService.updateListVideos(list: listPathVideo.value);
    } else {
      listPathAudio.value.removeAt(index);
      hiveService.updateListAudio(list: listPathAudio.value);
    }

    listPathPhotographs.update((val) {});
    listPathVideo.update((val) {});
    listPathAudio.update((val) {});
  }

  shareFile(String filePath) async {
    showLoadingComponent();

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(filePath)],
      ),
    );

    Get.back();
  }

  openFile({
    required String path,
    required int index,
    required String listName,
  }) async {
    final file = File(path);

    showLoadingComponent();

    bool fileExist = await file.exists();

    if (fileExist == true) {
      await OpenFilex.open(path);

      Get.back();
    } else {
      await deleFile(listName: listName, index: index);

      Get.back();
      FeedbackComponent.definitiveError(message: 'Arquivo não encontrado.');
    }
  }
}
