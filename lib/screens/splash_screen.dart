import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'app_drawer_screens/agenda_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void jump_to_homepage() {
    Navigator.of(context).pushReplacementNamed(AgendaScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), jump_to_homepage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
              "assets/images/WhatsApp_Image_2023-02-11_at_12.51.18_PM-removebg-preview.png"
              // child: Image.asset(
              //   "assets/splash_screen_bg/logo_final2.png",
              //   scale: 1.4,
              // ),
              ),
        ));
  }
}
