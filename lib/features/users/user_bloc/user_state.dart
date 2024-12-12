part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class GetUserCouponFailed extends UserState {
  final String message;
  const GetUserCouponFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingUserCoupon extends UserState {}

final class GetUserCouponSuccess extends UserState {
  final List<CouponModel> coupons;
  const GetUserCouponSuccess(
    this.coupons,
  );

  @override
  List<Object> get props => [
        coupons,
      ];
}

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

final class ChangePasswordLoading extends UserState {
  const ChangePasswordLoading();

  @override
  List<Object> get props => [];
}

final class ChangePasswordSuccess extends UserState {
  const ChangePasswordSuccess();

  @override
  List<Object> get props => [];
}

final class ChangePasswordFailure extends UserState {
  final String message;
  const ChangePasswordFailure({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

final class LoggingOut extends UserState {
  @override
  List<Object> get props => [];
}

final class LoggedOut extends UserState {
  @override
  List<Object> get props => [];
}

final class LogOutFailed extends UserState {
  final String message;
  const LogOutFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

class UploadPictureFailure extends UserState {
  final String message;
  const UploadPictureFailure({
    required this.message,
  });
  @override
  List<Object> get props => [
        message,
      ];
}

class UploadPictureLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UploadPictureSuccess extends UserState {
  final String userImage;
  const UploadPictureSuccess(
    this.userImage,
  );

  @override
  List<Object> get props => [
        userImage,
      ];
}

final class EditingProfile extends UserState {
  @override
  List<Object> get props => [];
}

final class EditProfileSuccess extends UserState {
  @override
  List<Object> get props => [];
}

final class EditProfileFailed extends UserState {
  final String message;
  const EditProfileFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}
