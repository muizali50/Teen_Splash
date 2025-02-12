part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

final class AddCoupon extends AdminEvent {
  final CouponModel coupon;
  final XFile image;
  const AddCoupon(
    this.coupon,
    this.image,
  );

  @override
  List<Object> get props => [
        coupon,
        image,
      ];
}

final class GetCoupon extends AdminEvent {}

final class UpdateCoupon extends AdminEvent {
  final CouponModel coupon;
  final XFile? image;
  const UpdateCoupon(
    this.coupon,
    this.image,
  );

  @override
  List<Object> get props => [
        coupon,
      ];
}

final class DeleteCoupon extends AdminEvent {
  final String couponId;
  const DeleteCoupon(
    this.couponId,
  );

  @override
  List<Object> get props => [
        couponId,
      ];
}

final class AddMondayOffers extends AdminEvent {
  final MondayOffersModel mondayOffer;
  final XFile image;
  final XFile businessLogo;
  const AddMondayOffers(
    this.mondayOffer,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        mondayOffer,
        image,
        businessLogo,
      ];
}

final class GetMondayOffers extends AdminEvent {}

final class UpdateMondayOffers extends AdminEvent {
  final MondayOffersModel mondayOffer;
  final XFile? image;
  final XFile? businessLogo;
  const UpdateMondayOffers(
    this.mondayOffer,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        mondayOffer,
      ];
}

final class DeleteMondayOffer extends AdminEvent {
  final String offerId;
  const DeleteMondayOffer(
    this.offerId,
  );

  @override
  List<Object> get props => [
        offerId,
      ];
}

final class AddFeaturedOffers extends AdminEvent {
  final FeaturedOffersModel featuredOffer;
  final XFile image;
  final XFile businessLogo;
  const AddFeaturedOffers(
    this.featuredOffer,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        featuredOffer,
        image,
        businessLogo,
      ];
}

final class GetFeaturedOffers extends AdminEvent {}

final class UpdateFeaturedOffers extends AdminEvent {
  final FeaturedOffersModel featuredOffer;
  final XFile? image;
  final XFile? businessLogo;
  const UpdateFeaturedOffers(
    this.featuredOffer,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        featuredOffer,
      ];
}

final class DeleteFeaturedOffer extends AdminEvent {
  final String offerId;
  const DeleteFeaturedOffer(
    this.offerId,
  );

  @override
  List<Object> get props => [
        offerId,
      ];
}

final class AddSponsors extends AdminEvent {
  final SponsorsModel sponsor;
  final XFile image;
  final XFile businessLogo;
  const AddSponsors(
    this.sponsor,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        sponsor,
        image,
        businessLogo,
      ];
}

final class GetSponsors extends AdminEvent {}

final class UpdateSponsors extends AdminEvent {
  final SponsorsModel sponsor;
  final XFile? image;
  final XFile? businessLogo;
  const UpdateSponsors(
    this.sponsor,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        sponsor,
      ];
}

final class DeleteSponsors extends AdminEvent {
  final String sponsorId;
  const DeleteSponsors(
    this.sponsorId,
  );

  @override
  List<Object> get props => [
        sponsorId,
      ];
}

final class AddWaterSponsor extends AdminEvent {
  final WaterSponsorModel waterSponsor;
  final XFile image;
  const AddWaterSponsor(
    this.waterSponsor,
    this.image,
  );
  @override
  List<Object> get props => [
        waterSponsor,
        image,
      ];
}

final class GetWaterSponsor extends AdminEvent {}

final class UpdateWaterSponsor extends AdminEvent {
  final WaterSponsorModel waterSponsor;
  final XFile? image;
  const UpdateWaterSponsor(
    this.waterSponsor,
    this.image,
  );

  @override
  List<Object> get props => [
        waterSponsor,
      ];
}

final class DeleteWaterSponsor extends AdminEvent {
  final String sponsorId;
  const DeleteWaterSponsor(
    this.sponsorId,
  );

  @override
  List<Object> get props => [
        sponsorId,
      ];
}

final class AddTickerNotification extends AdminEvent {
  final TickerNotificationModel pushNotification;
  const AddTickerNotification(
    this.pushNotification,
  );
  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class GetTickerNotification extends AdminEvent {}

final class UpdateTickerNotification extends AdminEvent {
  final TickerNotificationModel pushNotification;
  const UpdateTickerNotification(
    this.pushNotification,
  );
  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class DeleteTickerNotification extends AdminEvent {
  final String tickerNotificationId;
  const DeleteTickerNotification(
    this.tickerNotificationId,
  );

  @override
  List<Object> get props => [
        tickerNotificationId,
      ];
}

final class AddPushNotification extends AdminEvent {
  final PushNotificationModel pushNotification;
  const AddPushNotification(
    this.pushNotification,
  );
  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class GetPushNotification extends AdminEvent {}

final class UpdatePushNotification extends AdminEvent {
  final PushNotificationModel pushNotification;
  const UpdatePushNotification(
    this.pushNotification,
  );
  @override
  List<Object> get props => [
        pushNotification,
      ];
}

final class DeletePushNotification extends AdminEvent {
  final String pushNotificationId;
  const DeletePushNotification(
    this.pushNotificationId,
  );

  @override
  List<Object> get props => [
        pushNotificationId,
      ];
}

final class AddSurvey extends AdminEvent {
  final SurveyModel survey;
  const AddSurvey(
    this.survey,
  );
  @override
  List<Object> get props => [
        survey,
      ];
}

final class GetSurvey extends AdminEvent {}

final class UpdateSurvey extends AdminEvent {
  final SurveyModel survey;
  const UpdateSurvey(
    this.survey,
  );
  @override
  List<Object> get props => [
        survey,
      ];
}

final class SubmitSurveyAnswer extends AdminEvent {
  final String surveyId;
  final SurveyAnswerModel answer;
  const SubmitSurveyAnswer(
    this.surveyId,
    this.answer,
  );
  @override
  List<Object> get props => [
        surveyId,
        answer,
      ];
}

final class AddEvents extends AdminEvent {
  final EventsModel event;
  final XFile image;
  const AddEvents(
    this.event,
    this.image,
  );

  @override
  List<Object> get props => [
        event,
        image,
      ];
}

final class GetEvents extends AdminEvent {}

final class UpdateEvents extends AdminEvent {
  final EventsModel event;
  final XFile? image;
  const UpdateEvents(
    this.event,
    this.image,
  );

  @override
  List<Object> get props => [
        event,
      ];
}

final class GetSurveyAnswers extends AdminEvent {
  final String surveyId;
  const GetSurveyAnswers(
    this.surveyId,
  );

  @override
  List<Object> get props => [
        surveyId,
      ];
}

final class GetUnverifiedUsers extends AdminEvent {}

final class DeclineUser extends AdminEvent {
  final String userId;
  const DeclineUser(
    this.userId,
  );

  @override
  List<Object> get props => [
        userId,
      ];
}

final class RemoveUser extends AdminEvent {
  final String userId;
  const RemoveUser(
    this.userId,
  );

  @override
  List<Object> get props => [
        userId,
      ];
}

final class AddTeenBusiness extends AdminEvent {
  final TeenBusinessModel teenBusiness;
  final XFile image;
  final XFile businessLogo;
  const AddTeenBusiness(
    this.teenBusiness,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        teenBusiness,
        image,
        businessLogo,
      ];
}

final class GetTeenBusiness extends AdminEvent {}

final class UpdateTeenBusiness extends AdminEvent {
  final TeenBusinessModel teenBusiness;
  final XFile? image;
  final XFile? businessLogo;
  const UpdateTeenBusiness(
    this.teenBusiness,
    this.image,
    this.businessLogo,
  );

  @override
  List<Object> get props => [
        teenBusiness,
      ];
}

final class DeleteTeenBusiness extends AdminEvent {
  final String businessId;
  const DeleteTeenBusiness(
    this.businessId,
  );

  @override
  List<Object> get props => [
        businessId,
      ];
}

final class AddFavouriteFeaturedOffer extends AdminEvent {
  final String offerId;
  final String userId;
  const AddFavouriteFeaturedOffer(
    this.offerId,
    this.userId,
  );
  @override
  List<Object> get props => [
        offerId,
        userId,
      ];
}

final class AddFavouriteMondayOffer extends AdminEvent {
  final String offerId;
  final String userId;
  const AddFavouriteMondayOffer(
    this.offerId,
    this.userId,
  );
  @override
  List<Object> get props => [
        offerId,
        userId,
      ];
}

final class UpdateRestrictedWords extends AdminEvent {
  final List<String> words;
  const UpdateRestrictedWords(
    this.words,
  );
  @override
  List<Object> get props => [
        words,
      ];
}

final class GetRestrictedWords extends AdminEvent {}

final class AddPhotoGallery extends AdminEvent {
  final PhotoGalleryModel photoGallery;
  final XFile image;
  const AddPhotoGallery(
    this.photoGallery,
    this.image,
  );

  @override
  List<Object> get props => [
        photoGallery,
        image,
      ];
}

final class GetPhotoGallery extends AdminEvent {}

final class UpdatePhotoGallery extends AdminEvent {
  final PhotoGalleryModel photoGallery;
  final XFile? image;
  const UpdatePhotoGallery(
    this.photoGallery,
    this.image,
  );

  @override
  List<Object> get props => [
        photoGallery,
      ];
}

final class DeletePhotoGallery extends AdminEvent {
  final String photoGalleryId;
  const DeletePhotoGallery(
    this.photoGalleryId,
  );

  @override
  List<Object> get props => [
        photoGalleryId,
      ];
}
