class PayloadNotificationModel {
  late String date;
  late String taskId;

  PayloadNotificationModel({required this.date, required this.taskId});

  PayloadNotificationModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    taskId = json['taskId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'taskId': taskId,
    };
  }
}
