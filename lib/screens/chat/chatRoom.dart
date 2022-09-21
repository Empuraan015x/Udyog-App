// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/product_provider.dart';
import 'package:udyog/screens/chat/chatScreen.dart';
import 'package:udyog/services/firebase_services.dart';

class chatRoom extends StatefulWidget {
  static const String id = 'chat-room';

  @override
  State<chatRoom> createState() => _chatRoomState();
}

class _chatRoomState extends State<chatRoom> {
  FirebaseService _service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    var _productProvider = Provider.of<ProductProvider>(context);
    var data = _productProvider.productData;
    var userdata = _service.user;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 100,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          color: Colors.lightBlue.shade300,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data['company'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Colors.lightBlue.shade300,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data['address'],
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(
                              currentUser: userdata!.uid,
                              friendId: data['selleruid'],
                              friendName: data['company'],
                              friendImage: data['logourl']),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Text(
                      'Message',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
