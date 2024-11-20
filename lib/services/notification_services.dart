import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:teen_splash/features/users/views/hydrated_popup.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
onBackgroundNotificationHandler(response) {
  final context = navigatorKey.currentContext;

  if (context != null) {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: HydratedPopup(),
      ),
    );
  } else {
    debugPrint("No context available for background notification.");
  }
}

class NotificationsService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationsService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        _showPopup(navigatorKey.currentContext,
            response.payload ?? "Notification Clicked");
      },
      onDidReceiveBackgroundNotificationResponse:
          onBackgroundNotificationHandler,
    );
  }

  void _showPopup(BuildContext? context, String message) {
    showDialog(
      context: context!,
      builder: (context) => const Center(
        child: HydratedPopup(),
      ),
    );
  }

  Future<void> scheduleDailyNotifications() async {
    tz.initializeTimeZones();
    String timeZoneName = await FlutterTimezone.getLocalTimezone();
    final location = tz.getLocation(timeZoneName);
    tz.setLocalLocation(location);

    // Define the notification times (8 AM, 3 PM, 8 PM)
    List<int> hours = [8, 15, 20]; // 8 AM, 3 PM, 8 PM

    for (int i = 0; i < hours.length; i++) {
      // Get the current date at the given hour
      final now = DateTime.now();
      DateTime scheduledDate;

      // Check if the scheduled time today has passed. If so, schedule for tomorrow.
      if (now.hour >= hours[i]) {
        // Scheduled time has passed today, so set it for tomorrow
        scheduledDate = DateTime(now.year, now.month, now.day + 1, hours[i]);
      } else {
        // Scheduled time is still in the future today
        scheduledDate = DateTime(now.year, now.month, now.day, hours[i]);
      }

      // scheduledDate = DateTime.now().add(const Duration(minutes: 1));

      // Convert it to TZDateTime
      final scheduledTime = tz.TZDateTime.from(scheduledDate, location);

      // Print the scheduled time for debugging (in local time)
      print("Scheduled Time for ${hours[i]}: $scheduledTime");

      // Format the time for display in the notification
      final formattedTime = "${hours[i]} ${_getAmPm(hours[i])}";

      // Schedule the notification
      await _scheduleNotification(
        id: i,
        title: "Hydration Reminder",
        body: "Hydration Reminder to keep you hydrated",
        scheduledTime: scheduledTime,
      );
    }
  }

  String _getAmPm(int hour) {
    // Return the AM/PM format for the notification body
    return (hour >= 12 && hour < 24) ? 'PM' : 'AM';
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
  }) async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      'daily_notifications_channel',
      'Daily Notifications',
      channelDescription: 'Channel for daily notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails();

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }
}
