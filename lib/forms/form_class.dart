// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import '../provider/cat_provider.dart';

class FormClass {
  Widget appBar(CategoryProvider _provider) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      shape: Border(
        bottom: BorderSide(color: Colors.grey),
      ),
      title: Text(
        _provider.selectedCategory,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
