class AudioModel {
  late String path;
  late String date;
  late String audioTimer;

  AudioModel({
    required this.path,
    required this.date,
    required this.audioTimer,
  });

  AudioModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    date = json['date'];
    audioTimer = json['audioTimer'];
  }
}
