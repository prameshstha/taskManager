import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('tech');
  var initializeSetting = InitializationSettings(android: initializeAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializeSetting);
}

class LocalNotifications extends StatefulWidget {
  const LocalNotifications({Key? key}) : super(key: key);

  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {
  @override
  void initState() {
    initializeSetting();
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> displayNotification() async {
  flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Notification title',
      'body of notication',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      // tz.TZDateTime.from(dateTime, tz.local),
       NotificationDetails(
          android: AndroidNotificationDetails(
        'channel id',
        'channel name', 
      )),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);
}
