import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  late String? docId;
  late bool anytime;
  late DateTime creationDate;
  late String emoji;
  late int indexColor;
  late String nameTask;
  late List<String> repeat;
  late DateTime? schedules;

  TaskModel({
    this.docId,
    required this.anytime,
    required this.creationDate,
    required this.emoji,
    required this.indexColor,
    required this.nameTask,
    required this.repeat,
    required this.schedules,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    anytime = json['anytime'];
    creationDate = (json['creationDate'] as Timestamp).toDate();
    emoji = json['emoji'];
    indexColor = json['indexColor'];
    nameTask = json['nameTask'];
    repeat = List<String>.from(json['repeat']);
    schedules = json['schedules'] == null
        ? null
        : (json['schedules'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    return {
      'anytime': anytime,
      'creationDate': creationDate,
      'emoji': emoji,
      'indexColor': indexColor,
      'nameTask': nameTask,
      'repeat': repeat,
      'schedules': schedules,
    };
  }
}
