import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:teen_splash/features/users/views/hydrated_popup.dart';
import 'package:teen_splash/main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
@pragma('vm:entry-point')
void onBackgroundNotificationHandler(NotificationResponse response) async {
  debugPrint("Background notification tapped: ${response.payload}");

  navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (context) => const HydratedPopup(),
    ),
  );
}

void _handleNotificationTap(NotificationResponse response) {
  debugPrint("Notification tapped with payload: ${response.payload}");

  // navigatorKey.currentState?.push(
  //   MaterialPageRoute(
  //     builder: (context) => const HydratedPopup(),
  //   ),
  // );
  _showPopup(navigatorKey.currentState!.context);
}

void _showPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: HydratedPopup(),
    ),
  );
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

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (
      NotificationResponse response,
    ) {
      debugPrint("handleMessage called with payload: ${response.payload}");
      _handleNotificationTap(response);
    },
        onDidReceiveBackgroundNotificationResponse:
            onBackgroundNotificationHandler);

    // Handle notification tap when app is killed
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      final response = details!.notificationResponse;
      if (response != null) {
        Future.delayed(
          Duration.zero,
          () {
            _handleNotificationTap(response);
          },
        );
      }
    }
  }

  Future<void> scheduleDailyNotifications() async {
    // Cancel any existing notifications
    await flutterLocalNotificationsPlugin.cancelAll();

    tz.initializeTimeZones();
    String timeZoneName = await FlutterTimezone.getLocalTimezone();
    final location = tz.getLocation(timeZoneName);
    tz.setLocalLocation(location);

    // Define the notification times (8 AM, 3 PM, 8 PM)
    List<int> hours = [8, 15, 20];

    for (int dayOffset = 0; dayOffset < 7; dayOffset++) {
      for (int i = 0; i < hours.length; i++) {
        // Get the current date and calculate the scheduled time
        final now = DateTime.now();
        var scheduledDate = DateTime(
          now.year,
          now.month,
          now.day + dayOffset,
          hours[i],
        );

        // scheduledDate = DateTime.now().add(const Duration(minutes: 1));

        // Ensure the scheduled time is in the future
        final scheduledTime = tz.TZDateTime.from(scheduledDate, location);
        if (scheduledTime.isBefore(tz.TZDateTime.now(location))) {
          continue; // Skip if the time is in the past
        }

        // Debugging log
        print("Scheduled Time for ${hours[i]}: $scheduledTime");

        // Format the time for display in the notification
        final formattedTime = "${hours[i]} ${_getAmPm(hours[i])}";

        // Schedule the notification
        await _scheduleNotification(
          id: dayOffset * 100 + i, // Unique ID for each notification
          title: "Hydration Reminder",
          body: "Stay hydrated! Time for a drink of water.",
          scheduledTime: scheduledTime,
        );
      }
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
