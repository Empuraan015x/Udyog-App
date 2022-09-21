// ignore_for_file: prefer_const_constructors, duplicate_ignore, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_new, unused_element, import_of_legacy_library_into_null_safe, sized_box_for_whitespace, unused_import, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/screens/location_screen.dart';
import 'package:udyog/screens/product_list.dart';

import 'package:udyog/screens/subscreens/ads.dart';
import 'package:udyog/screens/profile/profile_screen.dart';
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
    var _catProvider = Provider.of<CategoryProvider>(context);
    _catProvider.getCategory(null);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SafeArea(child: CustomAppBar(),),),
      // ignore: prefer_const_constructors
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    BannerWidget(),
                    CategoryWidget(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ProductList(false),
          ],
        ),
      ),
    );
  }
}
