import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:teen_splash/features/users/views/bottom_nav_bar.dart';
import 'package:teen_splash/features/users/views/chats_screen.dart';
import 'package:teen_splash/features/users/views/sub_features/chat_room_screen/views/chat_room_screen.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final GlobalKey<NavigatorState> navigatorKey;

  PushNotificationService(this.navigatorKey);

  Future<void> init() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {}

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundNotification);

    // Handle notification tap when app is in background/killed
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  void _handleForegroundNotification(RemoteMessage message) {
    if (navigatorKey.currentContext != null) {
      InAppNotification.show(
        context: navigatorKey.currentContext!,
        child: GestureDetector(
          onTap: () {
            message.data['type'] == 'chatroom'
                ? navigatorKey.currentState?.push(
                    MaterialPageRoute(
                      builder: (context) => ChatRoomScreen(),
                    ),
                  )
                : message.data['type'] == 'chat'
                    ? navigatorKey.currentState?.push(
                        MaterialPageRoute(
                          builder: (context) => ChatsScreen(),
                        ),
                      )
                    : navigatorKey.currentState?.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(
                            isNotification: true,
                            initialMessage: message,
                          ),
                        ),
                      );
          },
          child: Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(navigatorKey.currentContext!).padding.top + 10,
              left: 16,
              right: 16,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF323232),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.notification!.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.notification!.body ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => BottomNavBar(
          isNotification: true,
        ),
      ),
    );
  }
}
