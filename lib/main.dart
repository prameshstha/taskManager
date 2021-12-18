import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/components/constant.dart';
import 'package:to_do_app/components/splash_screen.dart';
import 'package:to_do_app/screen/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/update_task_done_undone.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  // debugPaintSizeEnabled = true; //for color debugging
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UpdateTaskDone()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.poppinsTextTheme()),
        home: MySplashScren());
  }
}
