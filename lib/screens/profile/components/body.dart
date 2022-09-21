import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udyog/screens/login.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/images/usericon.svg",
            press: (){},
          ),
          SizedBox(height: 15,),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/images/notification.svg",
            press: (){},
          ),
          SizedBox(height: 15,),
          ProfileMenu(
            text: "Settings",
            icon: "assets/images/settings.svg",
            press: (){},
          ),
          SizedBox(height: 15,),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/images/question.svg",
            press: (){},
          ),
          SizedBox(height: 15,),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/images/logout.svg",
            press: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ScreenLogin()));
            },
          ),
        ],
      ),
    );
  }
}
