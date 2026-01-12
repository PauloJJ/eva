import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService extends GetxController {
  Rx<Box?> box = Rx(null);

  Rx<bool?> firstTimeOnTheApp = Rx(null);
  Rx<bool> firstSchedulingPolice = Rx(true);

  @override
  void onInit() {
    initHive();
    super.onInit();
  }

  initHive() async {
    final diretory = await getApplicationDocumentsDirectory();

    Hive.init(diretory.path);
    box.value = await Hive.openBox('myBox');

    getPreferences();
  }

  getPreferences() {
    getBoxs();
  }

  getBoxs() async {
    final firstApp = await box.value!.get('firstTimeOnTheApp');
    final schedulingPolice = await box.value!.get('firstSchedulingPolice');

    if (firstApp == null) {
      firstTimeOnTheApp.value = true;
    } else {
      firstTimeOnTheApp.value = firstApp;
    }

    if (schedulingPolice != null) {
      firstSchedulingPolice.value = schedulingPolice;
    }
  }

  updateFirstTimeOnTheApp() {
    box.value!.put('firstTimeOnTheApp', false);
    firstTimeOnTheApp.value = false;
  }

  updateFirstWelcomeSchedulingPolice() {
    box.value!.put('firstSchedulingPolice', false);
  }

  // Pegando Files do App  daqui pra baixo//

  // Fotos
  updateListPhotos({required List<String> list}) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    box.value!.put('listPathPhotographs_user_$userId', list);
  }

  getListPhotos() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final list = await box.value!.get('listPathPhotographs_user_$userId');

    List<String> listPathPhotographs = [];

    if (list != null) {
      listPathPhotographs = List<String>.from(list);
    }

    return listPathPhotographs;
  }

  // Videos
  updateListVideos({required List<Map<String, dynamic>> list}) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    box.value!.put('listPathVideo_user_$userId', list);
  }

  Future<List<Map<String, dynamic>>> getListVideo() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final list = await box.value!.get('listPathVideo_user_$userId');

    List<Map<String, dynamic>> listPathVideo = [];

    if (list != null) {
      for (var e in list) {
        Map<dynamic, dynamic> map = e;
        Map<String, dynamic> stringMap = map.cast<String, dynamic>();

        listPathVideo.add(stringMap);
      }
    }

    return listPathVideo;
  }

  // Audios
  updateListAudio({required List<Map<String, dynamic>> list}) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    box.value!.put('listPathAudio_user_$userId', list);
  }

  Future<List<Map<String, dynamic>>> getLisAudio() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final list = await box.value!.get('listPathAudio_user_$userId');

    List<Map<String, dynamic>> listPathAudio = [];

    if (list != null) {
      for (Map<dynamic, dynamic> map in list) {
        Map<String, dynamic> stringMap = map.cast<String, dynamic>();
        listPathAudio.add(stringMap);
      }
    }

    return listPathAudio;
  }
}
