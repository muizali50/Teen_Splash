part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

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
