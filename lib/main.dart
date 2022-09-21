// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udyog/forms/form_screen.dart';
import 'package:udyog/forms/user_review_screen.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/provider/product_provider.dart';
import 'package:udyog/screens/authentication/email_auth_screen.dart';
import 'package:udyog/screens/authentication/phoneauth_screen.dart';
import 'package:udyog/screens/authentication/reset_password_screen.dart';
import 'package:udyog/screens/chat/chat.dart';
import 'package:udyog/screens/chat/chatRoom.dart';
import 'package:udyog/screens/home.dart';
import 'package:udyog/screens/location_screen.dart';
import 'package:udyog/screens/login.dart';
import 'package:udyog/screens/main_screen.dart';
import 'package:udyog/screens/poduct_by_cat_screen.dart';
import 'package:udyog/screens/sellitems/seller_category_list.dart';
import 'package:udyog/screens/splash.dart';
import 'package:udyog/screens/subscreens/category_list.dart';
import 'package:udyog/screens/subscreens/product_details_screen.dart';
import 'screens/profile/profile_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => CategoryProvider()),
        Provider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Udyog',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Lato'),
      // home : ScreenSplash()
      initialRoute: ScreenSplash.id,
      routes: {
        ProductDetailsScreen.id : (context) => ProductDetailsScreen(),
        ScreenSplash.id: (context) => ScreenSplash(),
        ScreenLogin.id: (context) => ScreenLogin(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        EmailAuthScreen.id: (context) => EmailAuthScreen(),
        PasswordResetScreen.id: (context) => PasswordResetScreen(),
        CategoryListScreen.id: (context) => CategoryListScreen(),
        MainScreen.id: (context) => MainScreen(),
        SellerCategory.id: (context) => SellerCategory(),
        UserReviewScreen.id: (context) => UserReviewScreen(),
        FormScreen.id: (context) => FormScreen(),
        ProductByCategory.id: (context) => ProductByCategory(),
        chatRoom.id: (context) => chatRoom(),
        ChatsHome.id: (context) => ChatsHome(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
