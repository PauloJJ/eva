import 'package:hive/hive.dart';

class HiveService {
  var box = Hive.box('myBox');

  initHive() async {
    Hive.init('myBox');
    Hive.openBox('myBox');

    print('===============');

    // final teste = box.put('teste123', 'value');
  }
}
