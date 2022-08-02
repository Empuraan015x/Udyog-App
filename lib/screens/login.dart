// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:udyog/widgets/auth_ui.dart';

class ScreenLogin extends StatelessWidget {
  static const String id = 'login-scree';
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade700,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  Image.asset('assets/images/Udyog.png'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: AuthUi(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'By continuing, you agree to our Terms and Conditions & Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}
