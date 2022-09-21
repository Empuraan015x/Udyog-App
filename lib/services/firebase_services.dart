// ignore_for_file: unnecessary_new, import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:udyog/screens/home.dart';

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference chatroom =
      FirebaseFirestore.instance.collection('chatroom');

  Future<void> updateUser(Map<String, dynamic> data, context) {
    return users
        .doc(user!.uid)
        .update(data)
        .then(
          (value) => Navigator.pushNamed(context, HomeScreen.id),
        )
        .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update location'),
        ),
      );
    });
  }

  Future<String> getAddress(lat, long) async {
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    return first.addressLine;
  }

  Future<DocumentSnapshot> getUserData() async {
    DocumentSnapshot doc = await users.doc(user!.uid).get();
    return doc;
  }

  Future<DocumentSnapshot> getSellerData(id) async {
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;
  }

  updateFav(_isLiked, productId,context) {
    if (_isLiked) {
      products.doc(productId).update({
        'favourites': FieldValue.arrayUnion([user!.uid]),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to bookmarks'),
        ),
      );
    } else {
      products.doc(productId).update({
        'favourites': FieldValue.arrayRemove([user!.uid]),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Removed from bookmarks'),
        ),
      );
    }
  }
}
