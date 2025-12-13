import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late String cpf;
  late String phoneNumber;
  late String email;
  late String? pushToken;
  late String profileImage;

  late bool volunteerFairyGodmonther;
  late bool accountDeleted;
  late bool didTheTutorial;

  late DateTime lastSosActivated;
  late DateTime accountCreationDate;

  late GeoPoint? currentLocation;

  UserModel({
    required this.name,
    required this.cpf,
    required this.phoneNumber,
    required this.email,
    required this.pushToken,
    required this.profileImage,

    required this.volunteerFairyGodmonther,
    required this.accountDeleted,
    required this.didTheTutorial,

    required this.lastSosActivated,
    required this.accountCreationDate,

    required this.currentLocation,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cpf = json['cpf'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    pushToken = json['pushToken'];
    profileImage = json['profileImage'];

    volunteerFairyGodmonther = json['volunteerFairyGodmonther'];
    accountDeleted = json['accountDeleted'];
    didTheTutorial = json['didTheTutorial'];

    lastSosActivated = (json['lastSosActivated'] as Timestamp).toDate();
    accountCreationDate = (json['accountCreationDate'] as Timestamp).toDate();

    currentLocation = json['currentLocation'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cpf': cpf,
      'phoneNumber': phoneNumber,
      'email': email,
      'pushToken': pushToken,
      'profileImage': profileImage,
      'volunteerFairyGodmonther': volunteerFairyGodmonther,
      'accountDeleted': accountDeleted,
      'didTheTutorial': didTheTutorial,
      'lastSosActivated': lastSosActivated,
      'accountCreationDate': accountCreationDate,
      'currentLocation': currentLocation,
    };
  }
}
