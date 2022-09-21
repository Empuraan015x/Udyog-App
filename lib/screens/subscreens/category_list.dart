// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/screens/poduct_by_cat_screen.dart';


import '../../services/firebase_services.dart';

class CategoryListScreen extends StatelessWidget {
  static const String id = 'category-list-screen';
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    var _catProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future:
              _service.categories.orderBy('catName', descending: false).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              child: ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var doc = snapshot.data?.docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        _catProvider.getCategory(doc!['catName']);
                        _catProvider.getCatSnapshot(doc);
                        if (doc['subCat'] == null) {
                          Navigator.pushNamed(context, ProductByCategory.id);
                        }
                      },
                      leading: Image.network(
                        doc!['image'],
                        width: 80,
                      ),
                      title: Text(
                        doc['catName'],
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        size: 13,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
