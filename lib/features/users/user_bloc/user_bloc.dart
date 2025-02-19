import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teen_splash/main.dart';
import 'package:teen_splash/model/app_user.dart';
import 'package:teen_splash/model/coupon_model.dart';
import 'package:teen_splash/user_provider.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  List<CouponModel> coupons = [];
  List<AppUser> users = [];
  UserBloc() : super(UserInitial()) {
    on<GetUserCoupons>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingUserCoupon(),
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
            GetUserCouponSuccess(
              coupons,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetUserCouponFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetUserCouponFailed(
              e.toString(),
            ),
          );
        }
      },
    );
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

                  final index = coupons.indexWhere(
                      (coupon) => coupon.couponId == event.couponId);
                  if (index != -1) {
                    coupons[index].userIds = userIds;
                  }
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
    on<DownloadImage>(
      (
        event,
        emit,
      ) async {
        emit(
          DownloadingImage(),
        );
        try {
          // Request Storage Permission
          if (await Permission.storage.request().isGranted) {
            // Get Download Directory
            Directory? directory = await getExternalStorageDirectory();
            if (directory == null) {
              print("Failed to get directory");
              return;
            }

            // Generate File Path
            String fileName = event.imageUrl.split('/').last;
            String savePath = "${directory.path}/$fileName";

            // Start Download
            FileDownloader.downloadFile(
              url: event.imageUrl,
              name: fileName,
              onProgress: (String? fileName, double progress) {
                // 🔹 Now matches required type
                print("Downloading $fileName: ${progress.toStringAsFixed(2)}%");
              },
              onDownloadCompleted: (String path) {
                print("Download Completed: $path");
              },
              onDownloadError: (String error) {
                print("Download Failed: $error");
              },
            );
            emit(
              DownloadImageSuccess(savePath),
            );
          } else {
            print("Storage permission denied");
          }

          // final uri = Uri.parse(event.imageUrl);
          // final fileName = uri.pathSegments.last;
          // final response = await Dio().get(
          //   event.imageUrl,
          //   options: Options(responseType: ResponseType.bytes),
          // );

          // final result = await ImageGallerySaver.saveImage(
          //   Uint8List.fromList(response.data),
          //   quality: 100,
          //   name: fileName,
          // );

          // if (result['isSuccess']) {
          // emit(
          //   const DownloadImageSuccess("Image downloaded successfully!"),
          // );
          // } else {
          //   emit(
          //     const DownloadImageFailed("Failed to save the image."),
          //   );
          // }
        } on FirebaseException catch (e) {
          emit(
            DownloadImageFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DownloadImageFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<ChangePassword>(
      (
        event,
        emit,
      ) async {
        emit(
          const ChangePasswordLoading(),
        );
        try {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            final credential = EmailAuthProvider.credential(
              email: currentUser.email!,
              password: event.currentPassword,
            );
            await currentUser.reauthenticateWithCredential(
              credential,
            );
            await currentUser.updatePassword(
              event.newPassword,
            );

            emit(
              const ChangePasswordSuccess(),
            );
          }
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              ChangePasswordFailure(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              ChangePasswordFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              ChangePasswordFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<LogOut>(
      (
        event,
        emit,
      ) async {
        emit(
          LoggingOut(),
        );
        try {
          await FirebaseAuth.instance.signOut();
          emit(
            LoggedOut(),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            LogOutFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UploadPicture>(
      (
        event,
        emit,
      ) async {
        emit(
          UploadPictureLoading(),
        );
        try {
          String userImage = await uploadPicture(event.file, event.userId);
          UserProvider userProvider =
              navigatorKey.currentContext!.read<UserProvider>();
          userProvider.user!.picture = userImage;
          emit(
            UploadPictureSuccess(
              userImage,
            ),
          );
        } catch (e) {
          if (e is FirebaseException) {
            emit(
              UploadPictureFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              UploadPictureFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<EditProfile>(
      (
        event,
        emit,
      ) async {
        emit(
          EditingProfile(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          UserProvider userProvider =
              navigatorKey.currentContext!.read<UserProvider>();
          await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                userId,
              )
              .update(
            {
              'name': event.name,
              'email': event.email,
              'age': event.age,
              'gender': event.gender,
              'country': event.country,
              'countryFlag': event.countryFlag,
            },
          );
          userProvider.user!.name = event.name;
          userProvider.user!.email = event.email;
          userProvider.user!.age = event.age;
          userProvider.user!.gender = event.gender;
          userProvider.user!.country = event.country;
          userProvider.user!.countryFlag = event.countryFlag;
          emit(
            EditProfileSuccess(),
          );
        } on FirebaseException catch (e) {
          emit(
            EditProfileFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            EditProfileFailed(
              e.toString(),
            ),
          );
        }
      },
    );
  }
}

Future<String> uploadPicture(String file, String userId) async {
  File imageFile = File(file);
  Reference firebaseStoreRef = FirebaseStorage.instance.ref().child(
        '$userId/ProfilePictures/${userId}_lead',
      );
  await firebaseStoreRef.putFile(
    imageFile,
  );
  String url = await firebaseStoreRef.getDownloadURL();
  await FirebaseFirestore.instance.collection('users').doc(userId).update(
    {
      'picture': url,
    },
  );
  return url;
}
