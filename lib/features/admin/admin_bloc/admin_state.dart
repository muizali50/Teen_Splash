part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

final class AdminInitial extends AdminState {}

final class AddCouponFailed extends AdminState {
  final String message;
  const AddCouponFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingCoupon extends AdminState {}

final class AddCouponSuccess extends AdminState {
  final CouponModel coupon;
  const AddCouponSuccess(
    this.coupon,
  );

  @override
  List<Object> get props => [
        coupon,
      ];
}

final class GetCouponFailed extends AdminState {
  final String message;
  const GetCouponFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingCoupon extends AdminState {}

final class GetCouponSuccess extends AdminState {
  final List<CouponModel> coupons;
  const GetCouponSuccess(
    this.coupons,
  );

  @override
  List<Object> get props => [
        coupons,
      ];
}

final class UpdateCouponFailed extends AdminState {
  final String message;
  const UpdateCouponFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingCoupon extends AdminState {}

final class UpdateCouponSuccess extends AdminState {
  final CouponModel coupon;
  const UpdateCouponSuccess(
    this.coupon,
  );

  @override
  List<Object> get props => [
        coupon,
      ];
}

final class DeleteCouponSuccess extends AdminState {
  final String couponId;
  const DeleteCouponSuccess(
    this.couponId,
  );

  @override
  List<Object> get props => [
        couponId,
      ];
}

final class DeleteCouponFailed extends AdminState {
  final String message;
  const DeleteCouponFailed({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingCoupon extends AdminState {
  final String couponId;
  const DeletingCoupon(
    this.couponId,
  );

  @override
  List<Object> get props => [
        couponId,
      ];
}

final class AddMondayOffersFailed extends AdminState {
  final String message;
  const AddMondayOffersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingMondayOffers extends AdminState {}

final class AddMondayOffersSuccess extends AdminState {
  final MondayOffersModel mondayOffer;
  const AddMondayOffersSuccess(
    this.mondayOffer,
  );

  @override
  List<Object> get props => [
        mondayOffer,
      ];
}

final class GetMondayOffersFailed extends AdminState {
  final String message;
  const GetMondayOffersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingMondayOffers extends AdminState {}

final class GetMondayOffersSuccess extends AdminState {
  final List<MondayOffersModel> mondayOffers;
  const GetMondayOffersSuccess(
    this.mondayOffers,
  );

  @override
  List<Object> get props => [
        mondayOffers,
      ];
}

final class UpdateMondayOffersFailed extends AdminState {
  final String message;
  const UpdateMondayOffersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingMondayOffers extends AdminState {}

final class UpdateMondayOffersSuccess extends AdminState {
  final MondayOffersModel mondayOffer;
  const UpdateMondayOffersSuccess(
    this.mondayOffer,
  );

  @override
  List<Object> get props => [
        mondayOffer,
      ];
}

final class AddFeaturedOffersFailed extends AdminState {
  final String message;
  const AddFeaturedOffersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingFeaturedOffers extends AdminState {}

final class AddFeaturedOffersSuccess extends AdminState {
  final FeaturedOffersModel featuredOffer;
  const AddFeaturedOffersSuccess(
    this.featuredOffer,
  );

  @override
  List<Object> get props => [
        featuredOffer,
      ];
}

final class GetFeaturedOffersFailed extends AdminState {
  final String message;
  const GetFeaturedOffersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingFeaturedOffers extends AdminState {}

final class GetFeaturedOffersSuccess extends AdminState {
  final List<FeaturedOffersModel> featuredOffers;
  const GetFeaturedOffersSuccess(
    this.featuredOffers,
  );

  @override
  List<Object> get props => [
        featuredOffers,
      ];
}

final class UpdateFeaturedOffersFailed extends AdminState {
  final String message;
  const UpdateFeaturedOffersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingFeaturedOffers extends AdminState {}

final class UpdateFeaturedOffersSuccess extends AdminState {
  final FeaturedOffersModel featuredOffer;
  const UpdateFeaturedOffersSuccess(
    this.featuredOffer,
  );

  @override
  List<Object> get props => [
        featuredOffer,
      ];
}

final class AddSponsorFailed extends AdminState {
  final String message;
  const AddSponsorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingSponsor extends AdminState {}

final class AddSponsorSuccess extends AdminState {
  final SponsorsModel sponsor;
  const AddSponsorSuccess(
    this.sponsor,
  );

  @override
  List<Object> get props => [
        sponsor,
      ];
}

final class GetSponsorFailed extends AdminState {
  final String message;
  const GetSponsorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingSponsor extends AdminState {}

final class GetSponsorSuccess extends AdminState {
  final List<SponsorsModel> sponsors;
  const GetSponsorSuccess(
    this.sponsors,
  );

  @override
  List<Object> get props => [
        sponsors,
      ];
}

final class UpdateSponsorFailed extends AdminState {
  final String message;
  const UpdateSponsorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingSponsor extends AdminState {}

final class UpdateSponsorSuccess extends AdminState {
  final SponsorsModel sponsor;
  const UpdateSponsorSuccess(
    this.sponsor,
  );

  @override
  List<Object> get props => [
        sponsor,
      ];
}

final class DeleteSponsorSuccess extends AdminState {
  final String sponsorId;
  const DeleteSponsorSuccess(
    this.sponsorId,
  );

  @override
  List<Object> get props => [
        sponsorId,
      ];
}

final class DeleteSponsorFailed extends AdminState {
  final String message;
  const DeleteSponsorFailed({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingSponsor extends AdminState {
  final String sponsorId;
  const DeletingSponsor(
    this.sponsorId,
  );

  @override
  List<Object> get props => [
        sponsorId,
      ];
}

final class AddWaterSponsorFailed extends AdminState {
  final String message;
  const AddWaterSponsorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingWaterSponsor extends AdminState {}

final class AddWaterSponsorSuccess extends AdminState {
  final WaterSponsorModel waterSponsor;
  const AddWaterSponsorSuccess(
    this.waterSponsor,
  );

  @override
  List<Object> get props => [
        waterSponsor,
      ];
}

final class GetWaterSponsorFailed extends AdminState {
  final String message;
  const GetWaterSponsorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingWaterSponsor extends AdminState {}

final class GetWaterSponsorSuccess extends AdminState {
  final List<WaterSponsorModel> waterSponsors;
  const GetWaterSponsorSuccess(
    this.waterSponsors,
  );

  @override
  List<Object> get props => [
        waterSponsors,
      ];
}

final class UpdateWaterSponsorFailed extends AdminState {
  final String message;
  const UpdateWaterSponsorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingWaterSponsor extends AdminState {}

final class UpdateWaterSponsorSuccess extends AdminState {
  final WaterSponsorModel waterSponsor;
  const UpdateWaterSponsorSuccess(
    this.waterSponsor,
  );

  @override
  List<Object> get props => [
        waterSponsor,
      ];
}

final class AddTickerNotificationFailed extends AdminState {
  final String message;
  const AddTickerNotificationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingTickerNotification extends AdminState {}

final class AddTickerNotificationSuccess extends AdminState {
  final TickerNotificationModel pushNotification;
  const AddTickerNotificationSuccess(
    this.pushNotification,
  );

  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class GetTickerNotificationFailed extends AdminState {
  final String message;
  const GetTickerNotificationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingTickerNotification extends AdminState {}

final class GetTickerNotificationSuccess extends AdminState {
  final List<TickerNotificationModel> pushNotifications;
  const GetTickerNotificationSuccess(
    this.pushNotifications,
  );

  @override
  List<Object> get props => [
        pushNotifications,
      ];
}

final class UpdateTickerNotificationFailed extends AdminState {
  final String message;
  const UpdateTickerNotificationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingTickerNotification extends AdminState {}

final class UpdateTickerNotificationSuccess extends AdminState {
  final TickerNotificationModel pushNotification;
  const UpdateTickerNotificationSuccess(
    this.pushNotification,
  );

  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class AddPushNotificationFailed extends AdminState {
  final String message;
  const AddPushNotificationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingPushNotification extends AdminState {}

final class AddPushNotificationSuccess extends AdminState {
  final PushNotificationModel pushNotification;
  const AddPushNotificationSuccess(
    this.pushNotification,
  );

  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class GetPushNotificationFailed extends AdminState {
  final String message;
  const GetPushNotificationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingPushNotification extends AdminState {}

final class GetPushNotificationSuccess extends AdminState {
  final List<PushNotificationModel> pushNotifications;
  const GetPushNotificationSuccess(
    this.pushNotifications,
  );

  @override
  List<Object> get props => [
        pushNotifications,
      ];
}

final class UpdatePushNotificationFailed extends AdminState {
  final String message;
  const UpdatePushNotificationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingPushNotification extends AdminState {}

final class UpdatePushNotificationSuccess extends AdminState {
  final PushNotificationModel pushNotification;
  const UpdatePushNotificationSuccess(
    this.pushNotification,
  );

  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class AddSurveyFailed extends AdminState {
  final String message;
  const AddSurveyFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingSurvey extends AdminState {}

final class AddSurveySuccess extends AdminState {
  final SurveyModel survey;
  const AddSurveySuccess(
    this.survey,
  );

  @override
  List<Object> get props => [
        survey,
      ];
}

final class GetSurveyFailed extends AdminState {
  final String message;
  const GetSurveyFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingSurvey extends AdminState {}

final class GetSurveySuccess extends AdminState {
  final List<SurveyModel> surveys;
  const GetSurveySuccess(
    this.surveys,
  );

  @override
  List<Object> get props => [
        surveys,
      ];
}

final class UpdateSurveyFailed extends AdminState {
  final String message;
  const UpdateSurveyFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingSurvey extends AdminState {}

final class UpdateSurveySuccess extends AdminState {
  final SurveyModel survey;
  const UpdateSurveySuccess(
    this.survey,
  );

  @override
  List<Object> get props => [
        survey,
      ];
}

final class SubmittingSurveyAnswerFailed extends AdminState {
  final String message;
  const SubmittingSurveyAnswerFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class SubmittingSurveyAnswer extends AdminState {}

final class SubmittingSurveyAnswerSuccess extends AdminState {}

final class AddEventsFailed extends AdminState {
  final String message;
  const AddEventsFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddingEvents extends AdminState {}

final class AddEventsSuccess extends AdminState {
  final EventsModel event;
  const AddEventsSuccess(
    this.event,
  );

  @override
  List<Object> get props => [
        event,
      ];
}

final class GetEventsFailed extends AdminState {
  final String message;
  const GetEventsFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingEvents extends AdminState {}

final class GetEventsSuccess extends AdminState {
  final List<EventsModel> events;
  const GetEventsSuccess(
    this.events,
  );

  @override
  List<Object> get props => [
        events,
      ];
}

final class UpdateEventsFailed extends AdminState {
  final String message;
  const UpdateEventsFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingEvents extends AdminState {}

final class UpdateEventsSuccess extends AdminState {
  final EventsModel event;
  const UpdateEventsSuccess(
    this.event,
  );

  @override
  List<Object> get props => [
        event,
      ];
}

final class GetSurveyAnswersFailed extends AdminState {
  final String message;
  const GetSurveyAnswersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingSurveyAnswers extends AdminState {}

final class GetSurveyAnswersSuccess extends AdminState {
  final List<SurveyAnswerModel> answers;
  const GetSurveyAnswersSuccess(
    this.answers,
  );

  @override
  List<Object> get props => [
        answers,
      ];
}

final class GetUnverifiedUsersFailed extends AdminState {
  final String message;
  const GetUnverifiedUsersFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingUnverifiedUsers extends AdminState {}

final class GetUnverifiedUsersSuccess extends AdminState {
  final List<AppUser> users;
  const GetUnverifiedUsersSuccess(
    this.users,
  );

  @override
  List<Object> get props => [
        users,
      ];
}

final class DeclineUserSuccess extends AdminState {
  final String userId;
  const DeclineUserSuccess(
    this.userId,
  );

  @override
  List<Object> get props => [
        userId,
      ];
}

final class DeclineUserFailed extends AdminState {
  final String message;
  const DeclineUserFailed({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

final class DecliningUser extends AdminState {
  final String userId;
  const DecliningUser(
    this.userId,
  );

  @override
  List<Object> get props => [
        userId,
      ];
}

final class ApproveUserSuccess extends AdminState {
  final String userId;
  const ApproveUserSuccess(
    this.userId,
  );

  @override
  List<Object> get props => [
        userId,
      ];
}

final class ApproveUserFailed extends AdminState {
  final String message;
  const ApproveUserFailed({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

final class ApprovingUser extends AdminState {
  final String userId;
  const ApprovingUser(
    this.userId,
  );

  @override
  List<Object> get props => [
        userId,
      ];
}
