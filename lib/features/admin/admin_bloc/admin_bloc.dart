import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/model/coupon_model.dart';
import 'package:teen_splash/model/featured_offers_model.dart';
import 'package:teen_splash/model/monday_offers_model.dart';
import 'package:teen_splash/model/push_notification_model.dart';
import 'package:teen_splash/model/ticker_notification_model.dart';
import 'package:teen_splash/model/sponsors_model.dart';
import 'package:teen_splash/model/water_sponsor_model.dart';
part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  List<CouponModel> coupons = [];
  List<MondayOffersModel> mondayOffers = [];
  List<FeaturedOffersModel> featuredOffers = [];
  List<SponsorsModel> sponsors = [];
  List<WaterSponsorModel> waterSponsors = [];
  List<TickerNotificationModel> tickerNotifications = [];
  List<PushNotificationModel> pushNotifications = [];

  AdminBloc() : super(AdminInitial()) {
    on<AddCoupon>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingCoupon(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'coupon_business_images/${event.image.path.split('/').last}',
              );

          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.coupon.image = imageUrl;
          final couponCollection = FirebaseFirestore.instance.collection(
            'coupon',
          );
          final result = await couponCollection.add(
            event.coupon.toMap(),
          );
          event.coupon.couponId = result.id;
          coupons.add(
            event.coupon,
          );
          emit(
            AddCouponSuccess(
              event.coupon,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddCouponFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddCouponFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetCoupon>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingCoupon(),
        );
        try {
          final couponCollection = FirebaseFirestore.instance.collection(
            'coupon',
          );
          final result = await couponCollection.get();
          coupons = result.docs.map(
            (e) {
              final coupon = CouponModel.fromMap(
                e.data(),
              );
              coupon.couponId = e.id;
              return coupon;
            },
          ).toList();
          emit(
            GetCouponSuccess(
              coupons,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetCouponFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetCouponFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateCoupon>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingCoupon(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'coupon_business_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.coupon.image = imageUrl;
          }
          final couponCollection = FirebaseFirestore.instance.collection(
            'coupon',
          );
          await couponCollection
              .doc(
                event.coupon.couponId,
              )
              .update(
                event.coupon.toMap(),
              );
          final index = coupons.indexWhere(
            (element) => element.couponId == event.coupon.couponId,
          );
          coupons[index] = event.coupon;
          emit(
            UpdateCouponSuccess(
              event.coupon,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateCouponFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateCouponFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddMondayOffers>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingMondayOffers(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'monday_offers_images/${event.image.path.split('/').last}',
              );

          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.mondayOffer.image = imageUrl;
          final logoRef = FirebaseStorage.instance.ref().child(
                'monday_offers_business_logos/${event.businessLogo.path.split('/').last}',
              );

          await logoRef.putData(
            await event.businessLogo.readAsBytes(),
          );
          final logoUrl = await logoRef.getDownloadURL();
          event.mondayOffer.businessLogo = logoUrl;
          final mondayOfferCollection = FirebaseFirestore.instance.collection(
            'monday_offer',
          );
          final result = await mondayOfferCollection.add(
            event.mondayOffer.toMap(),
          );
          event.mondayOffer.offerId = result.id;
          mondayOffers.add(
            event.mondayOffer,
          );
          emit(
            AddMondayOffersSuccess(
              event.mondayOffer,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddMondayOffersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddMondayOffersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetMondayOffers>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingMondayOffers(),
        );
        try {
          final mondayOfferCollection = FirebaseFirestore.instance.collection(
            'monday_offer',
          );
          final result = await mondayOfferCollection.get();
          mondayOffers = result.docs.map(
            (e) {
              final mondayOffer = MondayOffersModel.fromMap(
                e.data(),
              );
              mondayOffer.offerId = e.id;
              return mondayOffer;
            },
          ).toList();
          emit(
            GetMondayOffersSuccess(
              mondayOffers,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetMondayOffersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetMondayOffersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateMondayOffers>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingMondayOffers(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'monday_offers_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.mondayOffer.image = imageUrl;
          }
          if (event.businessLogo != null) {
            final logoRef = FirebaseStorage.instance.ref().child(
                  'monday_offers_business_logos/${event.businessLogo!.path.split('/').last}',
                );
            await logoRef.putData(
              await event.businessLogo!.readAsBytes(),
            );
            final logoUrl = await logoRef.getDownloadURL();
            event.mondayOffer.businessLogo = logoUrl;
          }
          final mondayOfferCollection = FirebaseFirestore.instance.collection(
            'monday_offer',
          );
          await mondayOfferCollection
              .doc(
                event.mondayOffer.offerId,
              )
              .update(
                event.mondayOffer.toMap(),
              );
          final index = mondayOffers.indexWhere(
            (element) => element.offerId == event.mondayOffer.offerId,
          );
          mondayOffers[index] = event.mondayOffer;
          emit(
            UpdateMondayOffersSuccess(
              event.mondayOffer,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateMondayOffersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateMondayOffersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddFeaturedOffers>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingFeaturedOffers(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'featured_offers_images/${event.image.path.split('/').last}',
              );

          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.featuredOffer.image = imageUrl;
          final logoRef = FirebaseStorage.instance.ref().child(
                'featured_offers_business_logos/${event.businessLogo.path.split('/').last}',
              );

          await logoRef.putData(
            await event.businessLogo.readAsBytes(),
          );
          final logoUrl = await logoRef.getDownloadURL();
          event.featuredOffer.businessLogo = logoUrl;
          final featuredOfferCollection = FirebaseFirestore.instance.collection(
            'featured_offer',
          );
          final result = await featuredOfferCollection.add(
            event.featuredOffer.toMap(),
          );
          event.featuredOffer.offerId = result.id;
          featuredOffers.add(
            event.featuredOffer,
          );
          emit(
            AddFeaturedOffersSuccess(
              event.featuredOffer,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddFeaturedOffersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddFeaturedOffersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetFeaturedOffers>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingFeaturedOffers(),
        );
        try {
          final featuredOfferCollection = FirebaseFirestore.instance.collection(
            'featured_offer',
          );
          final result = await featuredOfferCollection.get();
          featuredOffers = result.docs.map(
            (e) {
              final featuredOffer = FeaturedOffersModel.fromMap(
                e.data(),
              );
              featuredOffer.offerId = e.id;
              return featuredOffer;
            },
          ).toList();
          emit(
            GetFeaturedOffersSuccess(
              featuredOffers,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetFeaturedOffersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetFeaturedOffersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateFeaturedOffers>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingFeaturedOffers(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'featured_offers_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.featuredOffer.image = imageUrl;
          }
          if (event.businessLogo != null) {
            final logoRef = FirebaseStorage.instance.ref().child(
                  'featured_offers_business_logos/${event.businessLogo!.path.split('/').last}',
                );
            await logoRef.putData(
              await event.businessLogo!.readAsBytes(),
            );
            final logoUrl = await logoRef.getDownloadURL();
            event.featuredOffer.businessLogo = logoUrl;
          }
          final featuredOfferCollection = FirebaseFirestore.instance.collection(
            'featured_offer',
          );
          await featuredOfferCollection
              .doc(
                event.featuredOffer.offerId,
              )
              .update(
                event.featuredOffer.toMap(),
              );
          final index = featuredOffers.indexWhere(
            (element) => element.offerId == event.featuredOffer.offerId,
          );
          featuredOffers[index] = event.featuredOffer;
          emit(
            UpdateFeaturedOffersSuccess(
              event.featuredOffer,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateFeaturedOffersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateFeaturedOffersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddSponsors>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingSponsor(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'sponsors_images/${event.image.path.split('/').last}',
              );

          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.sponsor.image = imageUrl;
          final logoRef = FirebaseStorage.instance.ref().child(
                'sponsors_business_logos/${event.businessLogo.path.split('/').last}',
              );

          await logoRef.putData(
            await event.businessLogo.readAsBytes(),
          );
          final logoUrl = await logoRef.getDownloadURL();
          event.sponsor.businessLogo = logoUrl;
          final sponsorCollection = FirebaseFirestore.instance.collection(
            'sponsor',
          );
          final result = await sponsorCollection.add(
            event.sponsor.toMap(),
          );
          event.sponsor.sponsorId = result.id;
          sponsors.add(
            event.sponsor,
          );
          emit(
            AddSponsorSuccess(
              event.sponsor,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddSponsorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddSponsorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetSponsors>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingSponsor(),
        );
        try {
          final sponsorCollection = FirebaseFirestore.instance.collection(
            'sponsor',
          );
          final result = await sponsorCollection.get();
          sponsors = result.docs.map(
            (e) {
              final sponsor = SponsorsModel.fromMap(
                e.data(),
              );
              sponsor.sponsorId = e.id;
              return sponsor;
            },
          ).toList();
          emit(
            GetSponsorSuccess(
              sponsors,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetSponsorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetSponsorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateSponsors>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingSponsor(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'sponsors_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.sponsor.image = imageUrl;
          }
          if (event.businessLogo != null) {
            final logoRef = FirebaseStorage.instance.ref().child(
                  'sponsors_business_logos/${event.businessLogo!.path.split('/').last}',
                );
            await logoRef.putData(
              await event.businessLogo!.readAsBytes(),
            );
            final logoUrl = await logoRef.getDownloadURL();
            event.sponsor.businessLogo = logoUrl;
          }
          final sponsorCollection = FirebaseFirestore.instance.collection(
            'sponsor',
          );
          await sponsorCollection
              .doc(
                event.sponsor.sponsorId,
              )
              .update(
                event.sponsor.toMap(),
              );
          final index = sponsors.indexWhere(
            (element) => element.sponsorId == event.sponsor.sponsorId,
          );
          sponsors[index] = event.sponsor;
          emit(
            UpdateSponsorSuccess(
              event.sponsor,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateSponsorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateSponsorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddWaterSponsor>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingWaterSponsor(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'water_sponsor_images/${event.image.path.split('/').last}',
              );

          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.waterSponsor.image = imageUrl;

          final waterSponsorCollection = FirebaseFirestore.instance.collection(
            'waterSponsor',
          );
          final result = await waterSponsorCollection.add(
            event.waterSponsor.toMap(),
          );
          event.waterSponsor.waterSponsorId = result.id;
          waterSponsors.add(
            event.waterSponsor,
          );
          emit(
            AddWaterSponsorSuccess(
              event.waterSponsor,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddWaterSponsorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddWaterSponsorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetWaterSponsor>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingWaterSponsor(),
        );
        try {
          final waterSponsorCollection = FirebaseFirestore.instance.collection(
            'waterSponsor',
          );
          final result = await waterSponsorCollection.get();
          waterSponsors = result.docs.map(
            (e) {
              final waterSponsor = WaterSponsorModel.fromMap(
                e.data(),
              );
              waterSponsor.waterSponsorId = e.id;
              return waterSponsor;
            },
          ).toList();
          emit(
            GetWaterSponsorSuccess(
              waterSponsors,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetWaterSponsorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetWaterSponsorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateWaterSponsor>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingWaterSponsor(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'water_sponsor_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.waterSponsor.image = imageUrl;
          }
          final waterSponsorCollection = FirebaseFirestore.instance.collection(
            'waterSponsor',
          );
          await waterSponsorCollection
              .doc(
                event.waterSponsor.waterSponsorId,
              )
              .update(
                event.waterSponsor.toMap(),
              );
          final index = waterSponsors.indexWhere(
            (element) =>
                element.waterSponsorId == event.waterSponsor.waterSponsorId,
          );
          waterSponsors[index] = event.waterSponsor;
          emit(
            UpdateWaterSponsorSuccess(
              event.waterSponsor,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateWaterSponsorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateWaterSponsorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddTickerNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingTickerNotification(),
        );
        try {
          final pushNotificationCollection =
              FirebaseFirestore.instance.collection(
            'tickerNotification',
          );
          final result = await pushNotificationCollection.add(
            event.pushNotification.toMap(),
          );
          event.pushNotification.pushNotificationId = result.id;
          tickerNotifications.add(
            event.pushNotification,
          );
          emit(
            AddTickerNotificationSuccess(
              event.pushNotification,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddTickerNotificationFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddTickerNotificationFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetTickerNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingTickerNotification(),
        );
        try {
          final pushNotificationCollection =
              FirebaseFirestore.instance.collection(
            'tickerNotification',
          );
          final result = await pushNotificationCollection.get();
          tickerNotifications = result.docs.map(
            (e) {
              final pushNotification = TickerNotificationModel.fromMap(
                e.data(),
              );
              pushNotification.pushNotificationId = e.id;
              return pushNotification;
            },
          ).toList();
          emit(
            GetTickerNotificationSuccess(
              tickerNotifications,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetTickerNotificationFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetTickerNotificationFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateTickerNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingTickerNotification(),
        );
        try {
          final pushNotificationCollection =
              FirebaseFirestore.instance.collection(
            'tickerNotification',
          );
          await pushNotificationCollection
              .doc(
                event.pushNotification.pushNotificationId,
              )
              .update(
                event.pushNotification.toMap(),
              );
          final index = tickerNotifications.indexWhere(
            (element) =>
                element.pushNotificationId ==
                event.pushNotification.pushNotificationId,
          );
          tickerNotifications[index] = event.pushNotification;
          emit(
            UpdateTickerNotificationSuccess(
              event.pushNotification,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateTickerNotificationFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateTickerNotificationFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddPushNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingPushNotification(),
        );
        try {
          final pushNotificationCollection =
              FirebaseFirestore.instance.collection(
            'pushNotification',
          );
          final result = await pushNotificationCollection.add(
            event.pushNotification.toMap(),
          );
          event.pushNotification.pushNotificationId = result.id;
          pushNotifications.add(
            event.pushNotification,
          );
          emit(
            AddPushNotificationSuccess(
              event.pushNotification,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddPushNotificationFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddPushNotificationFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetPushNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingPushNotification(),
        );
        try {
          final pushNotificationCollection =
              FirebaseFirestore.instance.collection(
            'pushNotification',
          );
          final result = await pushNotificationCollection.get();
          pushNotifications = result.docs.map(
            (e) {
              final pushNotification = PushNotificationModel.fromMap(
                e.data(),
              );
              pushNotification.pushNotificationId = e.id;
              return pushNotification;
            },
          ).toList();
          emit(
            GetPushNotificationSuccess(
              pushNotifications,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetPushNotificationFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetPushNotificationFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdatePushNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingPushNotification(),
        );
        try {
          final pushNotificationCollection =
              FirebaseFirestore.instance.collection(
            'pushNotification',
          );
          await pushNotificationCollection
              .doc(
                event.pushNotification.pushNotificationId,
              )
              .update(
                event.pushNotification.toMap(),
              );
          final index = pushNotifications.indexWhere(
            (element) =>
                element.pushNotificationId ==
                event.pushNotification.pushNotificationId,
          );
          pushNotifications[index] = event.pushNotification;
          emit(
            UpdatePushNotificationSuccess(
              event.pushNotification,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdatePushNotificationFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdatePushNotificationFailed(
              e.toString(),
            ),
          );
        }
      },
    );
  }
}
