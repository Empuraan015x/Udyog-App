// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:udyog/screens/authentication/phoneauth_screen.dart';
import 'package:udyog/services/phoneauth_service.dart';

import '../screens/authentication/email_auth_screen.dart';
import '../screens/authentication/google_auth.dart';

class AuthUi extends StatelessWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  // ignore: unnecessary_new
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(3.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, PhoneAuthScreen.id);
                },
                child: Row(
                  // ignore: duplicate_ignore, duplicate_ignore
                  children: [
                    Icon(
                      Icons.phone_android_outlined,
                      color: Colors.black,
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 8,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      'Continue with Phone',
                      // ignore: prefer_const_constructors
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                )),
          ),
          SignInButton(
            Buttons.Google,
            text: ('Continue with Google'),
            onPressed: () async {
              User? user =
                  await GoogleAuthentication.signInWithGoogle(context: context);
              if (user != null) {
                PhoneAuthService _authentication = PhoneAuthService();
                _authentication.addUser(context, user.uid);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'OR',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: (() {
              Navigator.pushNamed(context, EmailAuthScreen.id);
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white))),
                child: Text(
                  'Login with Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
