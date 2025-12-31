class PersonalNetworkModel {
  late String? docId;
  late String name;
  late String phoneNumber;
  late String email;
  late String? image;
  late String countryCode;

  PersonalNetworkModel({
    this.docId,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.image,
    required this.countryCode,
  });

  PersonalNetworkModel.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    image = json['image'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'image': image,
      'countryCode': countryCode,
    };
  }
}
