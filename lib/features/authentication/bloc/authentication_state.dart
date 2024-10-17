part of 'authentication_bloc.dart';

enum GetUserStatus { success, loading, failure }

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();

  @override
  List<Object?> get props => [];
}

final class AuthenticationSuccess extends AuthenticationState {
  const AuthenticationSuccess();

  @override
  List<Object?> get props => [];
}

final class AuthenticationFailure extends AuthenticationState {
  final String message;
  const AuthenticationFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

final class Registering extends AuthenticationState {
  const Registering();

  @override
  List<Object?> get props => [];
}

final class Registered extends AuthenticationState {
  final UserType? userType;
  const Registered(
    this.userType,
  );

  @override
  List<Object?> get props => [
        userType,
      ];
}

final class RegisteredFailure extends AuthenticationState {
  final String message;
  const RegisteredFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

final class ResetPasswordLoading extends AuthenticationState {
  const ResetPasswordLoading();

  @override
  List<Object?> get props => [];
}

final class ResetPasswordSuccess extends AuthenticationState {
  const ResetPasswordSuccess();

  @override
  List<Object?> get props => [];
}

final class ResetPasswordFailure extends AuthenticationState {
  final String message;
  const ResetPasswordFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

final class GetUserState extends AuthenticationState {
  final GetUserStatus status;
  final AppUser? user;
  const GetUserState._({
    this.status = GetUserStatus.loading,
    this.user,
  });

  const GetUserState.loading() : this._();
  const GetUserState.success(AppUser user)
      : this._(
          status: GetUserStatus.success,
          user: user,
        );
  const GetUserState.failure()
      : this._(
          status: GetUserStatus.failure,
        );

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}
