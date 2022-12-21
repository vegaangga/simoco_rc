import 'package:flutter/material.dart';
import 'package:simoco_rc/pages/login_page.dart';
import 'dart:async';


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return const LoginPage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D214F),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/images/seamoco.png",
            width: 300.0,
          ),
        ),
      ),
    );
  }
}