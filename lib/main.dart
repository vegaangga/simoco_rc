import 'package:flutter/material.dart';
import 'package:simoco_rc/pages/changeemail_page.dart';
import 'package:simoco_rc/pages/changepassword_page.dart';
import 'package:simoco_rc/pages/changetelp_page.dart';
import 'package:simoco_rc/pages/login_page.dart';
import 'package:simoco_rc/pages/qrcode_page.dart';
import 'package:simoco_rc/pages/splashscreen.dart';
import 'package:simoco_rc/providers/droppoint_provider.dart';
import 'package:provider/provider.dart';
import 'package:simoco_rc/widgets/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DroppointProvider()),
        //ListenableProvider(create: (context) => ContainerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'ss',
        routes: {
          'login': (context) => const LoginPage(),
          'ss': (context) => const SplashScreenPage(),
          // 'register' : (context) => Register(),
          // 'home' : (context) => const HomePage(),
          // // 'container':(context) => const DataContainer(),
          // 'profiles' : (context) => const ProfilePage(),
          'changeEmail' : (context) => const ChangeEmail_page(),
          'changePhone' : (context) => const ChangeTelp_page(),
          'changePassword': (context) => const ChangePassword_page(),
          'qrcode' : (context) => const QrCode(),
          'navbar' : (context) => const Navbar(),
        },
        home: const Navbar(),
      ),
    );

    // return const MaterialApp(
    //   title: 'SiMoco-RC',
    //   home: HomePage(),
    // );
  }
}