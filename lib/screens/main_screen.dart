// ignore_for_file: prefer_final_fields, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udyog/screens/chat/chat.dart';
import 'package:udyog/screens/chat/chatScreen.dart';
import 'package:udyog/screens/home.dart';
import 'package:udyog/screens/sellitems/seller_category_list.dart';
import 'package:udyog/screens/subscreens/ads.dart';
import 'package:udyog/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-screen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _currentScreen = HomeScreen();
  int _index = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      body: PageStorage(
        child: _currentScreen,
        bucket: _bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SellerCategory.id);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //left
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 0;
                        _currentScreen = HomeScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 0 ? Icons.home : Icons.home_outlined),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: _index == 0 ? color : Colors.black,
                              fontWeight: _index == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 1;
                        _currentScreen = ChatsHome();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 1
                            ? CupertinoIcons.chat_bubble_2_fill
                            : CupertinoIcons.chat_bubble_2),
                        Text(
                          'Chats',
                          style: TextStyle(
                              color: _index == 1 ? color : Colors.black,
                              fontWeight: _index == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //right
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 2;
                        _currentScreen = MyAdsScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 2
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart),
                        Text(
                          'My Ads',
                          style: TextStyle(
                              color: _index == 2 ? color : Colors.black,
                              fontWeight: _index == 2
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _index = 3;
                        _currentScreen = ProfileScreen();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_index == 3
                            ? CupertinoIcons.person_fill
                            : CupertinoIcons.person),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: _index == 3 ? color : Colors.black,
                              fontWeight: _index == 3
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
