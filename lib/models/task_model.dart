import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  late String? docId;
  late DateTime creationDate;
  late String emoji;
  late int indexColor;
  late String nameTask;
  late List<String> repeat;
  late DateTime? schedules;

  late String taskId;

  TaskModel({
    this.docId,
    required this.creationDate,
    required this.emoji,
    required this.indexColor,
    required this.nameTask,
    required this.repeat,
    required this.schedules,

    required this.taskId,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    creationDate = (json['creationDate'] as Timestamp).toDate();
    emoji = json['emoji'];
    indexColor = json['indexColor'];
    nameTask = json['nameTask'];
    repeat = List<String>.from(json['repeat']);
    schedules = json['schedules'] == null
        ? null
        : (json['schedules'] as Timestamp).toDate();

    taskId = json['taskId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'creationDate': creationDate,
      'emoji': emoji,
      'indexColor': indexColor,
      'nameTask': nameTask,
      'repeat': repeat,
      'schedules': schedules,
      'taskId': taskId,
    };
  }
}
