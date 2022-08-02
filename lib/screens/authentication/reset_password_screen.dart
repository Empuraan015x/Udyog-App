// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_new, duplicate_ignore

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udyog/screens/authentication/email_auth_screen.dart';

class PasswordResetScreen extends StatelessWidget {
  static const String id = 'password-reset-screen';
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColor,
                  size: 63,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Forgot\npassword?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Theme.of(context).primaryColor),
                ),
                Text(
                  'Send us your mail,\n we will send password reset link',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    labelText: 'Enter registered mail',
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  validator: (value) {
                    final bool isValid =
                        EmailValidator.validate(_emailController.text);
                    if (value == null || value.isEmpty) {
                      return 'Enter Email';
                    }
                    if (value.isNotEmpty && isValid == false) {
                      return 'Enter a valid Email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          // ignore: unnecessary_new
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Send'),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text)
                .then((value) {
              Navigator.pushReplacementNamed(context, EmailAuthScreen.id);
            });
          }
        },
      ),
    );
  }
}
