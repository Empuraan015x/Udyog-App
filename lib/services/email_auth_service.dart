// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udyog/screens/authentication/email_verify_screen.dart';
import 'package:udyog/screens/location_screen.dart';

class EmailAuthentication {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<DocumentSnapshot> getAdminCredential(
      {email, password, isLog, context}) async {
    DocumentSnapshot _result = await users.doc(email).get();

    if (isLog) {
      emailLogin(email, password, context);
    } else {
      if (_result.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account already exists'),
          ),
        );
      } else {
        emailRegister(email, password, context);
      }
    }

    return _result;
  }

  emailLogin(email, password, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided'),
          ),
        );
      }
    }
  }

  emailRegister(email, password, context) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
        return users.doc(credential.user?.uid).set({
          'uid': credential.user?.uid,
          'mobile': null,
          'email': credential.user?.email
        }).then((value) async {
          await credential.user?.sendEmailVerification().then((value) {
            Navigator.pushReplacementNamed(context, EmailVerificationScreen.id);
          });
        }).catchError((onError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email sent'),
            ),
          );
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password is weak'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account exists'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred'),
        ),
      );
    }
  }
}
