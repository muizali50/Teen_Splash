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
    };
  }
}
