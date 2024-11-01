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
