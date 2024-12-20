import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teen_splash/model/app_user.dart';
import 'package:teen_splash/model/coupon_model.dart';
import 'package:teen_splash/model/events_model.dart';
import 'package:teen_splash/model/featured_offers_model.dart';
import 'package:teen_splash/model/monday_offers_model.dart';
import 'package:teen_splash/model/push_notification_model.dart';
import 'package:teen_splash/model/survey_answer_model.dart';
import 'package:teen_splash/model/survey_model.dart';
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
  List<SurveyModel> surveys = [];
  List<EventsModel> events = [];
  List<AppUser> users = [];

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
    on<DeleteCoupon>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingCoupon(
            event.couponId,
          ),
        );
        try {
          final couponCollection = FirebaseFirestore.instance.collection(
            'coupon',
          );
          await couponCollection.doc(event.couponId).delete();
          coupons.removeWhere(
            (element) => element.couponId == event.couponId,
          );
          emit(
            DeleteCouponSuccess(
              event.couponId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeleteCouponFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeleteCouponFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeleteCouponFailed(
                message: e.toString(),
              ),
            );
          }
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
    on<DeleteSponsors>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingSponsor(
            event.sponsorId,
          ),
        );
        try {
          final sponsorCollection = FirebaseFirestore.instance.collection(
            'sponsor',
          );
          await sponsorCollection.doc(event.sponsorId).delete();
          sponsors.removeWhere(
            (element) => element.sponsorId == event.sponsorId,
          );
          emit(
            DeleteSponsorSuccess(
              event.sponsorId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeleteSponsorFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeleteSponsorFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeleteSponsorFailed(
                message: e.toString(),
              ),
            );
          }
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
    on<AddSurvey>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingSurvey(),
        );
        try {
          final surveyCollection = FirebaseFirestore.instance.collection(
            'survey',
          );
          final result = await surveyCollection.add(
            event.survey.toMap(),
          );
          event.survey.id = result.id;
          surveys.add(
            event.survey,
          );
          emit(
            AddSurveySuccess(
              event.survey,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddSurveyFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddSurveyFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetSurvey>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingSurvey(),
        );
        try {
          final surveyCollection = FirebaseFirestore.instance.collection(
            'survey',
          );
          final result = await surveyCollection.get();
          surveys = result.docs.map(
            (e) {
              final survey = SurveyModel.fromMap(
                e.data(),
              );
              survey.id = e.id;
              return survey;
            },
          ).toList();
          emit(
            GetSurveySuccess(
              surveys,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetSurveyFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetSurveyFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateSurvey>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingSurvey(),
        );
        try {
          final surveyCollection = FirebaseFirestore.instance.collection(
            'survey',
          );
          await surveyCollection
              .doc(
                event.survey.id,
              )
              .update(
                event.survey.toMap(),
              );
          final index = surveys.indexWhere(
            (element) => element.id == event.survey.id,
          );
          surveys[index] = event.survey;
          emit(
            UpdateSurveySuccess(
              event.survey,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateSurveyFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateSurveyFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<SubmitSurveyAnswer>(
      (
        event,
        emit,
      ) async {
        emit(
          SubmittingSurveyAnswer(),
        );
        try {
          await FirebaseFirestore.instance
              .collection('surveyAnswers')
              .doc(event.surveyId)
              .collection('answers')
              .add(event.answer.toMap());
          emit(
            SubmittingSurveyAnswerSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            SubmittingSurveyAnswerFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            SubmittingSurveyAnswerFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddEvents>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingEvents(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'event_images/${event.image.path.split('/').last}',
              );

          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.event.image = imageUrl;
          final eventCollection = FirebaseFirestore.instance.collection(
            'event',
          );
          final result = await eventCollection.add(
            event.event.toMap(),
          );
          event.event.eventId = result.id;
          events.add(
            event.event,
          );
          emit(
            AddEventsSuccess(
              event.event,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddEventsFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            AddEventsFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetEvents>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingEvents(),
        );
        try {
          final eventCollection = FirebaseFirestore.instance.collection(
            'event',
          );
          final result = await eventCollection.get();
          events = result.docs.map(
            (e) {
              final event = EventsModel.fromMap(
                e.data(),
              );
              event.eventId = e.id;
              return event;
            },
          ).toList();
          emit(
            GetEventsSuccess(
              events,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetEventsFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetEventsFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateEvents>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingEvents(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'event_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.event.image = imageUrl;
          }
          final eventCollection = FirebaseFirestore.instance.collection(
            'event',
          );
          await eventCollection
              .doc(
                event.event.eventId,
              )
              .update(
                event.event.toMap(),
              );
          final index = events.indexWhere(
            (element) => element.eventId == event.event.eventId,
          );
          events[index] = event.event;
          emit(
            UpdateEventsSuccess(
              event.event,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateEventsFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateEventsFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetUnverifiedUsers>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingUnverifiedUsers(),
        );
        try {
          final usersCollection = FirebaseFirestore.instance.collection(
            'users',
          );
          final result = await usersCollection.get();
          users = result.docs.map(
            (e) {
              final user = AppUser.fromMap(
                e.data(),
              );
              user.uid = e.id;
              return user;
            },
          ).toList();

          emit(
            GetUnverifiedUsersSuccess(
              users,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetUnverifiedUsersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetUnverifiedUsersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeclineUser>(
      (
        event,
        emit,
      ) async {
        emit(
          DecliningUser(
            event.userId,
          ),
        );
        try {
          final usersCollection = FirebaseFirestore.instance.collection(
            'users',
          );
          await usersCollection.doc(event.userId).delete();
          users.removeWhere(
            (element) => element.uid == event.userId,
          );
          emit(
            DeclineUserSuccess(
              event.userId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeclineUserFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeclineUserFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeclineUserFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<ApproveUser>(
      (
        event,
        emit,
      ) async {
        emit(
          ApprovingUser(
            event.userId,
          ),
        );
        try {
          final usersCollection = FirebaseFirestore.instance.collection(
            'users',
          );
          await usersCollection.doc(event.userId).update(
            {
              'status': 'Approved',
            },
          );
          // Update the local list
          final updatedUsers = users.map(
            (user) {
              if (user.uid == event.userId) {
                return user.copyWith(status: 'Approved');
              }
              return user;
            },
          ).toList();

          users = updatedUsers; // Update the list of users in the bloc
          emit(
            ApproveUserSuccess(
              event.userId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              ApproveUserFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              ApproveUserFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              ApproveUserFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<GetSurveyAnswers>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingSurveyAnswers(),
        );
        try {
          final answers = await _fetchSurveyAnswers(event.surveyId);
          emit(
            GetSurveyAnswersSuccess(
              answers,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetSurveyAnswersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetSurveyAnswersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
  }
  Future<List<SurveyAnswerModel>> _fetchSurveyAnswers(String surveyId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('surveyAnswers')
        .doc(surveyId)
        .collection('answers')
        .get();

    return snapshot.docs
        .map(
          (doc) => SurveyAnswerModel.fromMap(
            doc.data(),
          ),
        )
        .toList();
  }
}
