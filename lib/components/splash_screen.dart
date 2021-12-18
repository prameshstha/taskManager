import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:to_do_app/screen/home_screen/home_screen.dart';

class MySplashScren extends StatefulWidget {
  const MySplashScren({Key? key}) : super(key: key);

  @override
  _MySplashScrenState createState() => _MySplashScrenState();
}

class _MySplashScrenState extends State<MySplashScren> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomeScreen(),
        title: new Text('Welcome to Task Manager'),
        image: new Image.asset('assets/images/launch_image.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loadingText: Text('Loading...'),
        loaderColor: Colors.red);
  }
}
