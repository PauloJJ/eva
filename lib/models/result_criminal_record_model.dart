class ResultCriminalRecordModel {
  late String message;
  late int status;

  ResultCriminalRecordModel({required this.message, required this.status});

  ResultCriminalRecordModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }
}
