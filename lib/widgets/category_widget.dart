// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, unused_import, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/screens/poduct_by_cat_screen.dart';
import 'package:udyog/screens/subscreens/category_list.dart';

import '../services/firebase_services.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    var _catProvider = Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<QuerySnapshot>(
          future:
              _service.categories.orderBy('catName', descending: false).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }

            return Container(
              height: 140,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Categories',style: TextStyle(fontWeight: FontWeight.bold),)),
                      TextButton(
                        onPressed: () {
                          //show category as list
                          Navigator.pushNamed(context, CategoryListScreen.id);
                        },
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var doc = snapshot.data?.docs[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              _catProvider.getCategory(doc!['catName']);
                              _catProvider.getCatSnapshot(doc);
                              if (doc['subCat'] == null) {
                                Navigator.pushNamed(context, ProductByCategory.id);
                              }
                            },
                            child: Container(
                              width: 70,
                              height: 60,
                              child: Column(
                                children: [
                                  Image.network(doc!['image']),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      doc['catName'].toUpperCase(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
