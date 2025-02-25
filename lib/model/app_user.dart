import 'package:teen_splash/utils/enums.dart';

class AppUser {
  String? uid;
  String name;
  String email;
  UserType userType;
  String? gender;
  String? country;
  String? countryFlag;
  String? picture;
  String? idCardPicture;
  String? status;
  String? age;
  int? loginFrequency;
  String? dateOfBirth;
  String? membershipNumber;
  bool? isPrivacyPolicyAccepted;
  bool? isDeactivate;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.userType,
    this.country,
    this.countryFlag,
    this.gender,
    this.picture,
    this.idCardPicture,
    this.status,
    this.age,
    this.loginFrequency,
    this.dateOfBirth,
    this.membershipNumber,
    this.isPrivacyPolicyAccepted,
    this.isDeactivate,
  });

  AppUser copyWith({
    String? name,
    String? email,
    UserType? userType,
    String? country,
    String? gender,
    String? picture,
    String? countryFlag,
    String? idCardPicture,
    String? status,
    String? age,
    int? loginFrequency,
    String? dateOfBirth,
    String? membershipNumber,
    bool? isPrivacyPolicyAccepted,
    bool? isDeactivate,
  }) {
    return AppUser(
      uid: uid ?? uid,
      name: name ?? this.name,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      country: country ?? this.country,
      countryFlag: countryFlag ?? this.countryFlag,
      gender: gender ?? this.gender,
      picture: picture ?? this.picture,
      idCardPicture: idCardPicture ?? this.idCardPicture,
      status: status ?? this.status,
      age: age ?? this.age,
      loginFrequency: loginFrequency ?? this.loginFrequency,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      membershipNumber: membershipNumber ?? this.membershipNumber,
      isPrivacyPolicyAccepted:
          isPrivacyPolicyAccepted ?? this.isPrivacyPolicyAccepted,
      isDeactivate: isDeactivate ?? this.isDeactivate,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      country: map['country'] ?? '',
      userType: map['userType'] != null
          ? map['userType'] == UserType.user.toString()
              ? UserType.user
              : UserType.admin
          : UserType.admin,
      countryFlag: map['countryFlag'],
      gender: map['gender'] ?? '',
      picture: map['picture'] ?? '',
      idCardPicture: map['idCardPicture'] ?? '',
      status: map['status'] ?? '',
      age: map['age'] ?? '',
      loginFrequency: map['loginFrequency'] ?? 0,
      dateOfBirth: map['dateOfBirth'] ?? 0,
      membershipNumber: map['membershipNumber'] ?? 0,
      isPrivacyPolicyAccepted: map['isPrivacyPolicyAccepted'] ?? '',
      isDeactivate: map['isDeactivate'] ?? false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'country': country,
      'userType': userType.toString(),
      'countryFlag': countryFlag,
      'gender': gender,
      'picture': picture,
      'idCardPicture': idCardPicture,
      'status': status,
      'age': age,
      'loginFrequency': loginFrequency,
      'dateOfBirth': dateOfBirth,
      'membershipNumber': membershipNumber,
      'isPrivacyPolicyAccepted': isPrivacyPolicyAccepted,
      'isDeactivate': isDeactivate,
    };
  }
}
