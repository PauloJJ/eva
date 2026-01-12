import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva/models/user_model.dart';

class SchedulingPoliciaStationWomanModel {
  late String userId;
  late String timeScheduling;
  late DateTime dateScheduling;
  late DateTime requestDate;
  late bool requestProtectiveMeasures;
  late String address;
  late bool? itWasScheduled;
  UserModel? userModel;
  String? docId;

  SchedulingPoliciaStationWomanModel({
    required this.userId,
    required this.timeScheduling,
    required this.dateScheduling,
    required this.requestDate,
    required this.requestProtectiveMeasures,
    required this.address,
    required this.itWasScheduled,
    this.userModel,
    this.docId,
  });

  SchedulingPoliciaStationWomanModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    timeScheduling = json['timeScheduling'];
    dateScheduling = (json['dateScheduling'] as Timestamp).toDate();
    requestDate = (json['requestDate'] as Timestamp).toDate();
    requestProtectiveMeasures = json['requestProtectiveMeasures'];
    address = json['address'];
    itWasScheduled = json['itWasScheduled'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'timeScheduling': timeScheduling,
      'dateScheduling': dateScheduling,
      'requestDate': requestDate,
      'requestProtectiveMeasures': requestProtectiveMeasures,
      'address': address,
      'itWasScheduled': itWasScheduled,
    };
  }
}
