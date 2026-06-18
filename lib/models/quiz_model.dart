class QuizModel {
  late int id;
  late String question;
  late int points;
  late bool redFlag;
  late bool forceRed;

  QuizModel({
    required this.id,
    required this.question,
    required this.points,
    required this.redFlag,
    required this.forceRed,
  });

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    points = json['points'];
    redFlag = json['redFlag'];
    forceRed = json['forceRed'];
  }
}
