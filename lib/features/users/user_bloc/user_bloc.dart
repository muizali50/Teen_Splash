import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:teen_splash/model/app_user.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<AppUser> users = [];
  UserBloc() : super(UserInitial()) {
    on<RedeemCoupom>(
      (
        event,
        emit,
      ) async {
        emit(
          ReedeemingCoupon(),
        );
        try {
          final couponCollection =
              FirebaseFirestore.instance.collection('coupon');
          final docRef = couponCollection.doc(event.couponId);

          // Use transaction to safely add userId if it doesn't exist
          await FirebaseFirestore.instance.runTransaction(
            (transaction) async {
              final snapshot = await transaction.get(docRef);
              final data = snapshot.data();

              if (data != null) {
                final List<String> userIds = List<String>.from(
                  data['userIds'] ?? [],
                );

                final List<DateTime> redemptionDates =
                    (data['redemptionDates'] as List<dynamic>?)
                            ?.map((e) => DateTime.parse(e as String))
                            .toList() ??
                        [];

                if (!userIds.contains(event.userId)) {
                  userIds.add(event.userId);

                  // Add the current redemption date
                  final now = DateTime.now();
                  redemptionDates.add(now);
                  transaction.update(
                    docRef,
                    {
                      'userIds': userIds,
                      'redemptionDates': redemptionDates
                          .map((e) => e.toIso8601String())
                          .toList(),
                    },
                  );

                  String getDayOfWeek(int weekday) {
                    switch (weekday) {
                      case 1:
                        return 'Monday';
                      case 2:
                        return 'Tuesday';
                      case 3:
                        return 'Wednesday';
                      case 4:
                        return 'Thursday';
                      case 5:
                        return 'Friday';
                      case 6:
                        return 'Saturday';
                      case 7:
                        return 'Sunday';
                      default:
                        return '';
                    }
                  }

                  // Update day-wise count
                  final dayOfWeek = getDayOfWeek(now.weekday);
                  final Map<String, int> dayWiseCounts = Map<String, int>.from(
                    data['dayWiseCounts'] ??
                        {
                          'Monday': 0,
                          'Tuesday': 0,
                          'Wednesday': 0,
                          'Thursday': 0,
                          'Friday': 0,
                          'Saturday': 0,
                          'Sunday': 0,
                        },
                  );

                  // Increment count for the current day
                  dayWiseCounts[dayOfWeek] =
                      (dayWiseCounts[dayOfWeek] ?? 0) + 1;

                  transaction.update(
                    docRef,
                    {'dayWiseCounts': dayWiseCounts},
                  );
                }
              }
            },
          );
          emit(
            RedeemCouponSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            RedeemCouponFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            RedeemCouponFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetAllUsers>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingAllUsers(),
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
            GetAllUsersSuccess(
              users,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetAllUsersFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetAllUsersFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<ViewCoupom>(
      (
        event,
        emit,
      ) async {
        emit(
          ViewingCoupon(),
        );
        try {
          final couponCollection =
              FirebaseFirestore.instance.collection('coupon');
          final docRef = couponCollection.doc(event.couponId);

          // Use transaction to safely add userId if it doesn't exist
          await FirebaseFirestore.instance.runTransaction(
            (transaction) async {
              final snapshot = await transaction.get(docRef);
              final data = snapshot.data();

              if (data != null) {
                final List<String> views = List<String>.from(
                  data['views'] ?? [],
                );

                if (!views.contains(event.userId)) {
                  views.add(event.userId);
                  transaction.update(
                    docRef,
                    {'views': views},
                  );
                }
              }
            },
          );
          emit(
            ViewCouponSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            ViewCouponFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            ViewCouponFailed(
              e.toString(),
            ),
          );
        }
      },
    );
  }
}
