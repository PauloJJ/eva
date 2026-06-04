class TaskMocModel {
  late String nameTask;
  late String emoji;
  late List<String> repeat;
  late bool anytime;
  late List<String> schedules;

  TaskMocModel({
    required this.nameTask,
    required this.emoji,
    required this.repeat,
    required this.anytime,
    required this.schedules,
  });

  TaskMocModel.fromJson(Map<String, dynamic> json) {
    nameTask = json['nameTask'];
    emoji = json['emoji'];
    repeat = List<String>.from(json['repeat']);
    anytime = json['anytime'];
    schedules = List<String>.from(json['schedules']);
  }
}
