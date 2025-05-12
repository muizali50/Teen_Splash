import 'dart:convert';
import 'package:teen_splash/model/push_notification_model.dart';
import 'package:teen_splash/utils/serverkey.dart';
import 'package:http/http.dart' as http;

class AppUtils {
  Future<void> sendChatroomNotification(
      PushNotificationModel notification) async {
    final String url =
        'https://fcm.googleapis.com/v1/projects/teen-splah/messages:send';

    String serverToken = await get_server_key().server_token();
    Map<String, dynamic> payload;

    payload = {
      "message": {
        "topic": 'all_users',
        "notification": {
          "title": notification.title,
          "body": notification.content,
        },
        "data": {
          "type": "chatroom",
        },
      }
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $serverToken"
      },
      body: jsonEncode(payload),
    );

    print('📨 FCM Topic Response: ${response.statusCode}');
    print('📨 FCM Topic Body: ${response.body}');
  }

  Future<void> sendChatNotification(
      PushNotificationModel notification, String token) async {
    final String url =
        'https://fcm.googleapis.com/v1/projects/teen-splah/messages:send';
    final get = get_server_key();
    String serverToken = await get.server_token();

    Map<String, dynamic> payload;

    payload = {
      "message": {
        "token": token,
        "notification": {
          "title": notification.title,
          "body": notification.content,
        },
        "data": {
          "type": "chat",
        }
      }
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $serverToken"
      },
      body: jsonEncode(payload),
    );

    print('FCM Token Response for $token: ${response.statusCode}');
    print('FCM Token Body: ${response.body}');
  }
}
