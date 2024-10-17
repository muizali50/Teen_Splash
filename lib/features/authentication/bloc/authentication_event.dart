part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class RegisterEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String gender;
  final String country;
  final String countryFlag;
  final String password;
  final String confirmPassword;
  String idCardPhoto;
  final String status;
  final XFile? image;
  RegisterEvent({
    required this.name,
    required this.email,
    required this.gender,
    required this.country,
    required this.countryFlag,
    required this.password,
    required this.confirmPassword,
    required this.idCardPhoto,
    required this.status,
    this.image,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        gender,
        country,
        countryFlag,
        password,
        confirmPassword,
        idCardPhoto,
        status,
        image,
      ];
}

final class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;
  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

final class GetUser extends AuthenticationEvent {
  const GetUser();

  @override
  List<Object?> get props => [];
}

final class ResetPassword extends AuthenticationEvent {
  final String email;
  const ResetPassword({
    required this.email,
  });

  @override
  List<Object?> get props => [
        email,
      ];
}
