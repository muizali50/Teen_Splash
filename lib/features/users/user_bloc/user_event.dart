part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class GetUserCoupons extends UserEvent {}

final class RedeemCoupom extends UserEvent {
  final String couponId;
  final String userId;
  const RedeemCoupom(
    this.couponId,
    this.userId,
  );

  @override
  List<Object> get props => [
        couponId,
        userId,
      ];
}

final class GetAllUsers extends UserEvent {}

final class ViewCoupom extends UserEvent {
  final String couponId;
  final String userId;
  const ViewCoupom(
    this.couponId,
    this.userId,
  );

  @override
  List<Object> get props => [
        couponId,
        userId,
      ];
}

final class DownloadImage extends UserEvent {
  final String imageUrl;
  const DownloadImage(
    this.imageUrl,
  );

  @override
  List<Object> get props => [
        imageUrl,
      ];
}

final class ChangePassword extends UserEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  const ChangePassword({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });
  @override
  List<Object> get props => [
        currentPassword,
        newPassword,
        confirmNewPassword,
      ];
}

final class LogOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UploadPicture extends UserEvent {
  final String file;
  final String userId;
  const UploadPicture(
    this.file,
    this.userId,
  );

  @override
  List<Object> get props => [
        file,
        userId,
      ];
}

final class EditProfile extends UserEvent {
  final String name;
  final String email;
  final String age;
  final String gender;
  final String country;
  final String countryFlag;
  const EditProfile(
    this.name,
    this.email,
    this.age,
    this.gender,
    this.country,
    this.countryFlag,
  );
  @override
  List<Object> get props => [
        name,
        email,
        age,
        gender,
        country,
        countryFlag,
      ];
}

final class DeleteAccount extends UserEvent {
  @override
  List<Object> get props => [];
}

final class TooglePushNotification extends UserEvent {
  final bool isPushNotification;

  const TooglePushNotification(
    this.isPushNotification,
  );
  @override
  List<Object> get props => [
        isPushNotification,
      ];
}
