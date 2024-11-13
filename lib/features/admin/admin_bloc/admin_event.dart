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
