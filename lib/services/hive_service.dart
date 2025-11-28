import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService extends GetxController {
  Box? box;

  RxBool firstTimeOnTheApp = false.obs;

  @override
  void onInit() {
    initHive();
    super.onInit();
  }

  initHive() async {
    final diretory = await getApplicationDocumentsDirectory();

    Hive.init(diretory.path);
    box = await Hive.openBox('myBox');

    getPreferences();
  }

  getPreferences() async {
    final firstApp = await box!.get('firstTimeOnTheApp');

    if (firstApp != null) {
      firstTimeOnTheApp.value = firstApp;
    }
  }

  updateFirstTimeOnTheApp() {
    box!.put('firstTimeOnTheApp', true);
    firstTimeOnTheApp.value = true;
  }
}
