part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class ReedeemingCoupon extends UserState {}

final class RedeemCouponSuccess extends UserState {}

final class RedeemCouponFailed extends UserState {
  final String message;
  const RedeemCouponFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GetAllUsersFailed extends UserState {
  final String message;
  const GetAllUsersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingAllUsers extends UserState {}

final class GetAllUsersSuccess extends UserState {
  final List<AppUser> users;
  const GetAllUsersSuccess(
    this.users,
  );

  @override
  List<Object> get props => [
        users,
      ];
}

final class ViewingCoupon extends UserState {}

final class ViewCouponSuccess extends UserState {}

final class ViewCouponFailed extends UserState {
  final String message;
  const ViewCouponFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DownloadingImage extends UserState {}

final class DownloadImageSuccess extends UserState {
  final String filePath;
  const DownloadImageSuccess(
    this.filePath,
  );

  @override
  List<Object> get props => [
        filePath,
      ];
}

final class DownloadImageFailed extends UserState {
  final String message;
  const DownloadImageFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}
