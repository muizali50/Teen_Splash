import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:teen_splash/main.dart';
import 'package:teen_splash/model/app_user.dart';
import 'package:teen_splash/user_provider.dart';
import 'package:teen_splash/utils/enums.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final UserProvider userProvider =
        navigatorKey.currentContext!.read<UserProvider>();
    on<RegisterEvent>(
      (
        event,
        emit,
      ) async {
        emit(
          const Registering(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'idcard_images/${event.image!.path.split('/').last}',
              );

          await ref.putData(
            await event.image!.readAsBytes(),
          );
          final imageUrl = await ref.getDownloadURL();
          event.idCardPhoto = imageUrl;
          final userCreds =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(userCreds.user!.uid)
              .set(
            {
              'uid': userCreds.user!.uid,
              'name': event.name,
              'email': event.email,
              'userType': UserType.user.toString(),
              'gender': event.gender,
              'country': event.country,
              'countryFlag': event.countryFlag,
              'idCardPicture': event.idCardPhoto,
              'status': event.status,
            },
          );
          userProvider.setUser(
            AppUser(
              uid: userCreds.user!.uid,
              name: event.name,
              email: event.email,
              userType: UserType.user,
              gender: event.gender,
              country: event.country,
              countryFlag: event.countryFlag,
              idCardPicture: event.idCardPhoto,
              status: event.status,
            ),
          );
          emit(
            const Registered(
              UserType.user,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              RegisteredFailure(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              RegisteredFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              RegisteredFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<LoginEvent>(
      (
        event,
        emit,
      ) async {
        emit(
          const AuthenticationLoading(),
        );
        try {
          // Authenticate user with email and password
          final userCreds =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          if (!kIsWeb) {
            // Fetch user document from Firestore
            final userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(userCreds.user!.uid)
                .get();

            // Parse user data
            final userData = userDoc.data();
            if (userData == null) {
              emit(
                const AuthenticationFailure(
                  message: 'User data not found.',
                ),
              );
              return;
            }
            final AppUser user = AppUser.fromMap(userData);
            user.uid = userCreds.user!.uid;

            // Check if the user status is "Pending"
            if (user.status == 'Pending') {
              emit(
                const AuthenticationFailure(
                  message: 'Your request is under verification',
                ),
              );
              return;
            }

            // Update login frequency (if not on web)
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCreds.user!.uid)
                .update(
              {
                'loginFrequency': FieldValue.increment(1),
              },
            );

            // Set user data in UserProvider (if not on web)
            userProvider.setUser(user);
          }

          emit(
            const AuthenticationSuccess(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              AuthenticationFailure(
                message: e.code == 'invalid-login-credentials'
                    ? 'Invalid login credentials'
                    : e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              AuthenticationFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              AuthenticationFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<GetUser>(
      (
        event,
        emit,
      ) async {
        String uuid = FirebaseAuth.instance.currentUser!.uid;
        emit(
          const GetUserState.loading(),
        );
        try {
          final userDoc = await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                uuid,
              )
              .get();
          AppUser user = AppUser.fromMap(
            userDoc.data()!,
          );
          user.uid = uuid;
          userProvider.setUser(
            user,
          );
          emit(
            GetUserState.success(
              user,
            ),
          );
        } catch (e) {
          emit(
            const GetUserState.failure(),
          );
          if (e is FirebaseAuthException) {
            emit(
              AuthenticationFailure(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              AuthenticationFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              AuthenticationFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<ResetPassword>(
      (
        event,
        emit,
      ) async {
        emit(
          const ResetPasswordLoading(),
        );
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: event.email,
          );
          emit(
            const ResetPasswordSuccess(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              ResetPasswordFailure(message: e.message ?? ''),
            );
          } else if (e is FirebaseException) {
            emit(
              ResetPasswordFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              ResetPasswordFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
