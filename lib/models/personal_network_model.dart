import 'dart:math';

class PersonalNetworkModel {
  late String? docId;
  late String name;
  late String phoneNumber;
  late String? email;
  late String? image;
  late String idDismissible = Random().nextDouble().toString();

  PersonalNetworkModel({
    this.docId,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.image,
  });

  PersonalNetworkModel.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'image': image,
    };
  }
}
