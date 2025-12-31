import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioPlayerService extends GetxController {
  final String path;

  AudioPlayerService({required this.path});

  final player = AudioPlayer();

  RxString state = 'playing'.obs;

  @override
  void onInit() {
    initPlayer();
    super.onInit();
  }

  @override
  void onClose() {
    player.stop();
    super.onClose();
  }

  initPlayer() async {
    await player.setSource(
      DeviceFileSource(path),
    );

    await player.resume();

    state.bindStream(streamPlayer());
  }

  togglePlayer() async {
    if (state.value == 'playing') {
      await player.pause();
    } else if (state.value == 'paused' || state.value == 'completed') {
      player.resume();
    }
  }

  Stream<String> streamPlayer() async* {
    await for (var e in player.onPlayerStateChanged) {
      if (e.name == 'completed') {
        completedRefresh();
      }

      yield e.name;
    }
  }

  completedRefresh() async {
    await player.setSource(
      DeviceFileSource(path),
    );

    state.bindStream(streamPlayer());
  }
}
