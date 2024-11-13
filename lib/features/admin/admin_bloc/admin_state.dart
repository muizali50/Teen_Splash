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
