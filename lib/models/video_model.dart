class VideoModel {
  late String path;
  late String date;

  VideoModel({
    required this.path,
    required this.date,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    date = json['date'];
  }
}
