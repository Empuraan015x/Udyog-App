// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:udyog/services/firebase_services.dart';
import 'package:udyog/widgets/message_textfield.dart';
import 'package:udyog/widgets/single_message.dart';

class ChatScreen extends StatelessWidget {
  FirebaseService _service = FirebaseService();
  static const String id = 'chat-screen';
  final String currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;

  ChatScreen({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
  });

  @override
  Widget build(BuildContext context) {
    var usersdata = _service.users;
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: Image.network(
                  'https://cdn4.iconfinder.com/data/icons/green-shopper/1068/user.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              friendName,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: StreamBuilder(
                  stream: usersdata.doc(currentUser).collection('messages').doc(friendId).collection('chats').orderBy("date",descending: true).snapshots(),
                  builder: (context,AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data.docs.length < 1){
                        return Center(
                          child: Text("Say Hi"),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context,index){
                            bool isMe = snapshot.data.docs[index]['senderId'] == currentUser;
                            return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe);
                          });
                    }
                    return Center(
                        child: CircularProgressIndicator()
                    );
                  }),
            ),
          ),
          MessageTextField(currentUser, friendId),
        ],
      ),
    );
  }
}
