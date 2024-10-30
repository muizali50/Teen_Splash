import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
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

                if (!userIds.contains(event.userId)) {
                  userIds.add(event.userId);
                  transaction.update(
                    docRef,
                    {'userIds': userIds},
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
  }
}
