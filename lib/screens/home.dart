// ignore_for_file: prefer_const_constructors, duplicate_ignore, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_new, unused_element, import_of_legacy_library_into_null_safe, sized_box_for_whitespace, unused_import, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:udyog/screens/location_screen.dart';

import 'package:udyog/screens/subscreens/ads.dart';
import 'package:udyog/screens/subscreens/chats.dart';
import 'package:udyog/screens/subscreens/profile.dart';
import 'package:udyog/widgets/banner_widget.dart';
import 'package:udyog/widgets/category_widget.dart';
import 'package:udyog/widgets/custom_appBar.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'India';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: SafeArea(child: CustomAppBar())),
      // ignore: prefer_const_constructors
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Find Jobs',
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.notifications_none),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                BannerWidget(),
                CategoryWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
