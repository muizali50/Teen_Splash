import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TestNotificationsService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TestNotificationsService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  /// Initializes the notifications service with platform-specific settings
  Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    // Set platform-specific initialization settings
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
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
        _showPopup(navigatorKey.currentContext, response.payload ?? "Notification Clicked");
      },
    );

    // Request notification permissions
    await _requestPermissions();
  }

  /// Requests notification permissions for Android 13+ and iOS
  Future<void> _requestPermissions() async {
    // Request Android notification permission (Android 13+)
    if (await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission() == false) {
      print("Notification permissions not granted.");
    }
  }

  /// Shows a dialog popup when a notification is clicked
  void _showPopup(BuildContext? context, String message) {
    showDialog(
      context: context!,
      builder: (context) => AlertDialog(
        title: const Text("Notification"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  /// Schedules a test notification to show immediately after a short delay (e.g., 2 minutes)
  Future<void> scheduleImmediateNotification() async {
    // Initialize timezone settings and set local timezone
    tz.initializeTimeZones();
    String timeZoneName =await FlutterTimezone.getLocalTimezone();
    final location = tz.getLocation(timeZoneName);
    tz.setLocalLocation(location);

    // Schedule for 2 minutes later
    final scheduledDate = DateTime.now().add(const Duration(minutes: 2));
    final scheduledTime = tz.TZDateTime.from(scheduledDate, location);

    print("Test Scheduled Time: $scheduledTime");

    // Schedule the notification
    await _scheduleNotification(
      id: 0, // Unique notification ID
      title: "Immediate Test Notification",
      body: "This is your test notification scheduled in 2 minutes.",
      scheduledTime: scheduledTime,
    );
  }

  /// Schedules a notification at a specified time
  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
  }) async {
    // Define Android and iOS notification details
    const androidDetails = AndroidNotificationDetails(
      'teen_splash', // Channel ID
      'Teen Splash', // Channel Name
      channelDescription: 'Teen Splash Notification Channel',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
    );

    print("Notification scheduled for: $scheduledTime");
  }
}
