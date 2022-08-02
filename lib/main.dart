// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:udyog/screens/authentication/email_auth_screen.dart';
import 'package:udyog/screens/authentication/phoneauth_screen.dart';
import 'package:udyog/screens/authentication/reset_password_screen.dart';

import 'package:udyog/screens/home.dart';
import 'package:udyog/screens/location_screen.dart';
import 'package:udyog/screens/login.dart';
import 'package:udyog/screens/main_screen.dart';
import 'package:udyog/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Udyog',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Lato'),
      initialRoute: ScreenSplash.id,
      routes: {
        ScreenSplash.id: (context) => ScreenSplash(),
        ScreenLogin.id: (context) => ScreenLogin(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        EmailAuthScreen.id: (context) => EmailAuthScreen(),
        PasswordResetScreen.id: (context) => PasswordResetScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
