// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:udyog/screens/chat/chatScreen.dart';
import 'package:udyog/services/firebase_services.dart';

class ChatsHome extends StatelessWidget {
  static const String id = 'chat-screen';

  ChatsHome({Key? key}) : super(key: key);

  FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    var usersdata = _service.users;
    var userdata = _service.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
          stream:
              usersdata.doc(userdata!.uid).collection('messages').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return Center(
                  child: Text("No Chats Available !"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendId = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];
                    return FutureBuilder(
                      future: usersdata.doc(friendId).get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return ListTile(
                            leading: Image.network('https://www.iconshock.com/image/Impressions/Database/user'),
                            title: Text(friend['name'] ?? 'Anonymous'),
                            subtitle: Container(
                              child: Text(
                                "$lastMsg",
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                                  currentUser: userdata.uid,
                                  friendId: friend['uid'],
                                  friendName: friend['name'],
                                  friendImage: friend['name'])));
                            },

                          );
                        }
                        return LinearProgressIndicator();
                      },
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
