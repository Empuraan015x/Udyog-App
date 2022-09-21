// ignore_for_file: unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:udyog/services/firebase_services.dart';

class CategoryProvider with ChangeNotifier {
  FirebaseService _service = FirebaseService();
  late DocumentSnapshot doc;
  late DocumentSnapshot userDetails;
  late String selectedCategory;
  Map<String, dynamic> dataToFirestore = {};

  getCategory(selectedCat) {
    this.selectedCategory = selectedCat;
    notifyListeners();
  }

  getCatSnapshot(snapshot) {
    this.doc = snapshot;
    notifyListeners();
  }

  getData(data) {
    this.dataToFirestore = data;
    notifyListeners();
  }

  getUserDetails() {
    _service.getUserData().then((value) {
      this.userDetails = value;
      notifyListeners();
    });
  }

  clearData() {
    dataToFirestore = {};
    notifyListeners();
  }
}
