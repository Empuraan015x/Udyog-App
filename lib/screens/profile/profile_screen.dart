import 'package:flutter/material.dart';
import 'package:udyog/screens/profile/components/body.dart';


class ProfileScreen extends StatelessWidget {
  static String id = 'profile-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 2.0,
      ),
      body: Body(),
    );
  }
}
