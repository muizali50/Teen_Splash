import 'dart:math';
import 'dart:developer' as developer;
import 'dart:typed_data';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:teen_splash/model/app_user.dart';
import 'package:teen_splash/model/coupon_model.dart';
import 'package:teen_splash/model/events_model.dart';
import 'package:teen_splash/model/featured_offers_model.dart';
import 'package:teen_splash/model/monday_offers_model.dart';
import 'package:teen_splash/model/photo_gallery_model.dart';
import 'package:teen_splash/model/push_notification_model.dart';
import 'package:teen_splash/model/restricted_words.dart';
import 'package:teen_splash/model/survey_answer_model.dart';
import 'package:teen_splash/model/survey_model.dart';
import 'package:teen_splash/model/teen_business_model.dart';
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
  List<TeenBusinessModel> teenBusinesses = [];
  List<AppUser> users = [];
  RestrictedWordsModel? restricedWords;
  List<PhotoGalleryModel> photoGalleries = [];

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
          final documentId = result.id;
          event.coupon.couponId = documentId;
          await couponCollection.doc(documentId).update(
            {
              'couponId': documentId,
            },
          );
          // Generate and upload QR code (now we have a document ID)
          String? qrCodeUrl = await generateAndUploadQRCode(documentId);

          // Update Firestore with the QR code URL
          await couponCollection.doc(documentId).update(
            {
              'qrCodeUrl': qrCodeUrl,
            },
          );
          event.coupon.qrCodeUrl = qrCodeUrl;
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
    on<DeleteMondayOffer>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingMondayOffer(
            event.offerId,
          ),
        );
        try {
          final mondayOffersCollection = FirebaseFirestore.instance.collection(
            'monday_offer',
          );
          await mondayOffersCollection.doc(event.offerId).delete();
          mondayOffers.removeWhere(
            (element) => element.offerId == event.offerId,
          );
          emit(
            DeleteMondayOfferSuccess(
              event.offerId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeleteMondayOfferFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeleteMondayOfferFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeleteMondayOfferFailed(
                message: e.toString(),
              ),
            );
          }
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
    on<DeleteFeaturedOffer>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingFeaturedOffer(
            event.offerId,
          ),
        );
        try {
          final featuredOffersCollection =
              FirebaseFirestore.instance.collection(
            'featured_offer',
          );
          await featuredOffersCollection.doc(event.offerId).delete();
          featuredOffers.removeWhere(
            (element) => element.offerId == event.offerId,
          );
          emit(
            DeleteFeaturedOfferSuccess(
              event.offerId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeleteFeaturedOfferFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeleteFeaturedOfferFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeleteFeaturedOfferFailed(
                message: e.toString(),
              ),
            );
          }
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
    on<DeleteWaterSponsor>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingWaterSponsor(
            event.sponsorId,
          ),
        );
        try {
          final waterSponsorCollection = FirebaseFirestore.instance.collection(
            'waterSponsor',
          );
          await waterSponsorCollection.doc(event.sponsorId).delete();
          waterSponsors.removeWhere(
            (element) => element.waterSponsorId == event.sponsorId,
          );
          emit(
            DeleteWaterSponsorSuccess(
              event.sponsorId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeleteWaterSponsorFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeleteWaterSponsorFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeleteWaterSponsorFailed(
                message: e.toString(),
              ),
            );
          }
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
    on<DeleteTickerNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingTickerNotification(
            event.tickerNotificationId,
          ),
        );
        try {
          final tickerNotificationCollection =
              FirebaseFirestore.instance.collection(
            'tickerNotification',
          );
          await tickerNotificationCollection
              .doc(event.tickerNotificationId)
              .delete();
          tickerNotifications.removeWhere(
            (element) =>
                element.pushNotificationId == event.tickerNotificationId,
          );
          emit(
            DeleteTickerNotificationSuccess(
              event.tickerNotificationId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeleteTickerNotificationFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeleteTickerNotificationFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeleteTickerNotificationFailed(
                message: e.toString(),
              ),
            );
          }
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
    on<DeletePushNotification>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingPushNotification(
            event.pushNotificationId,
          ),
        );
        try {
          final pushNotificationCollection =
              FirebaseFirestore.instance.collection(
            'pushNotification',
          );
          await pushNotificationCollection
              .doc(event.pushNotificationId)
              .delete();
          pushNotifications.removeWhere(
            (element) => element.pushNotificationId == event.pushNotificationId,
          );
          emit(
            DeletePushNotificationSuccess(
              event.pushNotificationId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeletePushNotificationFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeletePushNotificationFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeletePushNotificationFailed(
                message: e.toString(),
              ),
            );
          }
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
          developer.log(
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
    on<RemoveUser>(
      (
        event,
        emit,
      ) async {
        emit(
          RemovingUser(
            event.userId,
          ),
        );
        try {
          final usersCollection = FirebaseFirestore.instance.collection(
            'users',
          );
          await usersCollection.doc(event.userId).update(
            {
              'status': 'Pending',
            },
          );
          // Update the local list
          final updatedUsers = users.map(
            (user) {
              if (user.uid == event.userId) {
                return user.copyWith(status: 'Pending');
              }
              return user;
            },
          ).toList();

          users = updatedUsers; // Update the list of users in the bloc
          emit(
            RemoveUserSuccess(
              event.userId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              RemoveUserFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              RemoveUserFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              RemoveUserFailed(
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
          developer.log(
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
    on<AddTeenBusiness>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingTeenBusiness(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'teen_businesses_images/${event.image.path.split('/').last}',
              );
          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.teenBusiness.image = imageUrl;
          final logoRef = FirebaseStorage.instance.ref().child(
                'teen_businesses_logos/${event.businessLogo.path.split('/').last}',
              );

          await logoRef.putData(
            await event.businessLogo.readAsBytes(),
          );
          final logoUrl = await logoRef.getDownloadURL();
          event.teenBusiness.businessLogo = logoUrl;
          final teenBusinessCollection = FirebaseFirestore.instance.collection(
            'teen_business',
          );
          final result = await teenBusinessCollection.add(
            event.teenBusiness.toMap(),
          );
          event.teenBusiness.businessId = result.id;
          teenBusinesses.add(
            event.teenBusiness,
          );
          emit(
            AddTeenBusinessSuccess(
              event.teenBusiness,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddTeenBusinessFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            AddTeenBusinessFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetTeenBusiness>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingTeenBusiness(),
        );
        try {
          final teenBusinessCollection = FirebaseFirestore.instance.collection(
            'teen_business',
          );
          final result = await teenBusinessCollection.get();
          teenBusinesses = result.docs.map(
            (e) {
              final teenBusiness = TeenBusinessModel.fromMap(
                e.data(),
              );
              teenBusiness.businessId = e.id;
              return teenBusiness;
            },
          ).toList();
          emit(
            GetTeenBusinessSuccess(
              teenBusinesses,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetTeenBusinessFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            GetTeenBusinessFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateTeenBusiness>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingTeenBusiness(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'teen_businesses_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.teenBusiness.image = imageUrl;
          }
          if (event.businessLogo != null) {
            final logoRef = FirebaseStorage.instance.ref().child(
                  'teen_businesses_logos/${event.businessLogo!.path.split('/').last}',
                );
            await logoRef.putData(
              await event.businessLogo!.readAsBytes(),
            );
            final logoUrl = await logoRef.getDownloadURL();
            event.teenBusiness.businessLogo = logoUrl;
          }
          final teenBusinessCollection = FirebaseFirestore.instance.collection(
            'teen_business',
          );
          await teenBusinessCollection
              .doc(
                event.teenBusiness.businessId,
              )
              .update(
                event.teenBusiness.toMap(),
              );
          final index = teenBusinesses.indexWhere(
            (element) => element.businessId == event.teenBusiness.businessId,
          );
          teenBusinesses[index] = event.teenBusiness;
          emit(
            UpdateTeenBusinessSuccess(
              event.teenBusiness,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateTeenBusinessFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            UpdateTeenBusinessFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteTeenBusiness>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingTeenBusiness(
            event.businessId,
          ),
        );
        try {
          final teenBusinessCollection = FirebaseFirestore.instance.collection(
            'teen_business',
          );
          await teenBusinessCollection.doc(event.businessId).delete();
          teenBusinesses.removeWhere(
            (element) => element.businessId == event.businessId,
          );
          emit(
            DeleteTeenBusinessSuccess(
              event.businessId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeleteTeenBusinessFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeleteTeenBusinessFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeleteTeenBusinessFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<AddFavouriteFeaturedOffer>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingFavouriteFeaturedOffer(),
        );
        try {
          final offerDoc = FirebaseFirestore.instance
              .collection('featured_offer')
              .doc(event.offerId);
          final docSnapshot = await offerDoc.get();
          final data = docSnapshot.data()!;
          final List<String> favorites =
              List<String>.from(data['isFavorite'] ?? []);

          if (favorites.contains(event.userId)) {
            favorites.remove(event.userId);
          } else {
            favorites.add(event.userId);
          }

          await offerDoc.update(
            {
              'isFavorite': favorites,
            },
          );

          for (var offer in featuredOffers) {
            if (offer.offerId == event.offerId) {
              offer.isFavorite = favorites;
              break;
            }
          }
          emit(
            AddFavouriteFeaturedOfferSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            AddFavouriteFeaturedOfferFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            AddFavouriteFeaturedOfferFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddFavouriteMondayOffer>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingFavouriteMondayOffer(),
        );
        try {
          final offerDoc = FirebaseFirestore.instance
              .collection('monday_offer')
              .doc(event.offerId);
          final docSnapshot = await offerDoc.get();
          final data = docSnapshot.data()!;
          final List<String> favorites =
              List<String>.from(data['isFavorite'] ?? []);

          if (favorites.contains(event.userId)) {
            favorites.remove(event.userId);
          } else {
            favorites.add(event.userId);
          }
          await offerDoc.update(
            {
              'isFavorite': favorites,
            },
          );

          for (var offer in mondayOffers) {
            if (offer.offerId == event.offerId) {
              offer.isFavorite = favorites;
              break;
            }
          }
          emit(
            AddFavouriteMondayOfferSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            AddFavouriteMondayOfferFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            AddFavouriteMondayOfferFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateRestrictedWords>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingRestrictedWords(),
        );
        try {
          final updatedWords = RestrictedWordsModel(
            words: event.words,
            updatedAt: DateTime.now(),
          );
          await FirebaseFirestore.instance
              .collection("restricted_words")
              .doc('bad_words')
              .set(
                updatedWords.toMap(),
              );
          restricedWords = updatedWords;
          emit(
            UpdateRestrictedWordsSuccess(
              restricedWords!,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateRestrictedWordsFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            UpdateRestrictedWordsFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetRestrictedWords>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingRestrictedWords(),
        );
        try {
          final words = await fetchRestrictedWords();
          if (words != null) {
            restricedWords = words;
            emit(GetRestrictedWordsSuccess(words));
          } else {
            emit(const GetRestrictedWordsFailed("No restricted words found"));
          }
        } on FirebaseException catch (e) {
          emit(
            GetRestrictedWordsFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            GetRestrictedWordsFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<AddPhotoGallery>(
      (
        event,
        emit,
      ) async {
        emit(
          AddingPhotoGallery(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'photo_gallery_images/${event.image.path.split('/').last}',
              );

          await ref.putData(
            await event.image.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.photoGallery.image = imageUrl;
          final photoGalleryCollection = FirebaseFirestore.instance.collection(
            'photo_gallery',
          );
          final result = await photoGalleryCollection.add(
            event.photoGallery.toMap(),
          );
          final documentId = result.id;
          event.photoGallery.photoGalleryId = documentId;
          await photoGalleryCollection.doc(documentId).update(
            {
              'photoGalleryId': documentId,
            },
          );

          photoGalleries.add(
            event.photoGallery,
          );
          emit(
            AddPhotoGallerySuccess(
              event.photoGallery,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            AddPhotoGalleryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );

          emit(
            AddPhotoGalleryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetPhotoGallery>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingPhotoGallery(),
        );
        try {
          final photoGalleryCollection = FirebaseFirestore.instance.collection(
            'photo_gallery',
          );
          final result = await photoGalleryCollection.get();
          photoGalleries = result.docs.map(
            (e) {
              final photoGallery = PhotoGalleryModel.fromMap(
                e.data(),
              );
              photoGallery.photoGalleryId = e.id;
              return photoGallery;
            },
          ).toList();
          emit(
            GetPhotoGallerySuccess(
              photoGalleries,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetPhotoGalleryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            GetPhotoGalleryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdatePhotoGallery>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingPhotoGallery(),
        );
        try {
          if (event.image != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'photo_gallery_images/${event.image!.path.split('/').last}',
                );
            await ref.putData(
              await event.image!.readAsBytes(),
            );
            final imageUrl = await ref.getDownloadURL();
            event.photoGallery.image = imageUrl;
          }
          final photoGalleryCollection = FirebaseFirestore.instance.collection(
            'photo_gallery',
          );
          await photoGalleryCollection
              .doc(
                event.photoGallery.photoGalleryId,
              )
              .update(
                event.photoGallery.toMap(),
              );
          final index = photoGalleries.indexWhere(
            (element) =>
                element.photoGalleryId == event.photoGallery.photoGalleryId,
          );
          photoGalleries[index] = event.photoGallery;
          emit(
            UpdatePhotoGallerySuccess(
              event.photoGallery,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdatePhotoGalleryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            UpdatePhotoGalleryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeletePhotoGallery>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingPhotoGallery(
            event.photoGalleryId,
          ),
        );
        try {
          final photoGalleryCollection = FirebaseFirestore.instance.collection(
            'photo_gallery',
          );
          await photoGalleryCollection.doc(event.photoGalleryId).delete();
          photoGalleries.removeWhere(
            (element) => element.photoGalleryId == event.photoGalleryId,
          );
          emit(
            DeletePhotoGallerySuccess(
              event.photoGalleryId,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              DeletePhotoGalleryFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              DeletePhotoGalleryFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              DeletePhotoGalleryFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<RedeemFeauturedOffer>(
      (event, emit) async {
        emit(
          ReedeemingFeaturedOffer(),
        );
        try {
          final offerCollection =
              FirebaseFirestore.instance.collection('featured_offer');
          final docRef = offerCollection.doc(event.offerId);

          await FirebaseFirestore.instance.runTransaction(
            (transaction) async {
              final snapshot = await transaction.get(docRef);
              final data = snapshot.data();

              if (data != null) {
                final List<String> userIds = List<String>.from(
                  data['userIds'] ?? [],
                );

                final Map<String, List<String>> userOfferCodes =
                    (data['userOfferCodes'] != null)
                        ? (data['userOfferCodes'] as Map<String, dynamic>).map(
                            (key, value) => MapEntry(
                              key,
                              (value as List<dynamic>)
                                  .map((e) => e.toString())
                                  .toList(),
                            ),
                          )
                        : {};

                // Generate a unique 4-digit code
                String generateOfferCode() {
                  final random = Random();
                  return (1000 + random.nextInt(9000)).toString();
                }

                String offerCode;
                do {
                  offerCode = generateOfferCode();
                } while (userOfferCodes.values.any(
                  (codes) => codes.contains(offerCode),
                ));

                // Add userId and offerCode (allows multiple codes for the same user)
                userIds.add(event.userId);
                userOfferCodes
                    .putIfAbsent(event.userId, () => [])
                    .add(offerCode);

                transaction.update(
                  docRef,
                  {
                    'userIds': userIds,
                    'userOfferCodes': userOfferCodes,
                  },
                );

                // Update local list
                final index = featuredOffers.indexWhere(
                  (offer) => offer.offerId == event.offerId,
                );
                if (index != -1) {
                  featuredOffers[index].userIds = userIds;
                  featuredOffers[index].userOfferCodes = userOfferCodes;
                }
              }
            },
          );
          emit(
            RedeemFeaturedOfferSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            RedeemFeaturedOfferFailed(e.message ?? ''),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            RedeemFeaturedOfferFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<RedeemMondayOffer>(
      (event, emit) async {
        emit(
          ReedeemingMondayOffer(),
        );
        try {
          final offerCollection =
              FirebaseFirestore.instance.collection('monday_offer');
          final docRef = offerCollection.doc(event.offerId);

          await FirebaseFirestore.instance.runTransaction(
            (transaction) async {
              final snapshot = await transaction.get(docRef);
              final data = snapshot.data();

              if (data != null) {
                final List<String> userIds = List<String>.from(
                  data['userIds'] ?? [],
                );

                final Map<String, String> userOfferCodes =
                    Map<String, String>.from(
                  data['userOfferCodes'] ?? {},
                );

                if (userIds.contains(event.userId)) {
                  throw Exception("You have already redeemed this offer.");
                }

                // Generate a unique 4-digit code
                String generateOfferCode() {
                  final random = Random();
                  return (1000 + random.nextInt(9000))
                      .toString(); // Ensures 4 digits
                }

                String offerCode;
                do {
                  offerCode = generateOfferCode();
                } while (userOfferCodes
                    .containsValue(offerCode)); // Ensure uniqueness

                // Add userId and offerCode
                userIds.add(event.userId);
                userOfferCodes[event.userId] = offerCode;

                transaction.update(
                  docRef,
                  {
                    'userIds': userIds,
                    'userOfferCodes': userOfferCodes,
                  },
                );

                // Update local list
                final index = mondayOffers.indexWhere(
                  (offer) => offer.offerId == event.offerId,
                );
                if (index != -1) {
                  mondayOffers[index].userIds = userIds;
                  mondayOffers[index].userOfferCodes = userOfferCodes;
                }
              }
            },
          );
          emit(
            RedeemMondayOfferSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            RedeemMondayOfferFailed(e.message ?? ''),
          );
        } catch (e) {
          developer.log(
            e.toString(),
          );
          emit(
            RedeemMondayOfferFailed(
              e.toString(),
            ),
          );
        }
      },
    );
  }

  Future<String?> generateAndUploadQRCode(String couponId) async {
    try {
      print("Generating QR Code for Web - Coupon ID: $couponId");

      // Generate QR Code Image
      final qrImage = await QrPainter(
        data: couponId,
        version: QrVersions.auto,
        color: const Color(0xFF000000),
      ).toImage(200);

      final byteData = await qrImage.toByteData(format: ImageByteFormat.png);
      if (byteData == null) {
        throw Exception("QR code ByteData is null!");
      }

      final Uint8List uint8List = byteData.buffer.asUint8List();

      // Upload to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child('qrcodes/$couponId.png');
      final uploadTask =
          ref.putData(uint8List, SettableMetadata(contentType: "image/png"));

      // ✅ Wait for Upload Completion & Get Download URL
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      print("QR Code uploaded. Download URL: $downloadUrl");

      // ✅ Save QR Code URL in Firestore
      await FirebaseFirestore.instance.collection('coupon').doc(couponId).set({
        'qrCodeUrl': downloadUrl,
      }, SetOptions(merge: true));

      print("QR Code URL saved in Firestore.");

      return downloadUrl; // ✅ Return the URL
    } catch (e) {
      print("Error generating/uploading QR code: $e");
      return null; // Return null if there's an error
    }
  }

  Future<RestrictedWordsModel?> fetchRestrictedWords() async {
    final doc = await FirebaseFirestore.instance
        .collection("restricted_words")
        .doc('bad_words')
        .get();
    final restrictedWords = RestrictedWordsModel.fromMap(
      doc.data()!,
    );
    if (doc.exists) {
      return restrictedWords;
    }
    return null;
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
