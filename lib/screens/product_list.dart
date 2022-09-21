// ignore_for_file: unnecessary_new, prefer_const_constructors, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/services/firebase_services.dart';
import 'package:udyog/widgets/product_card.dart';

class ProductList extends StatelessWidget {
  final bool proScreen;

  ProductList(this.proScreen);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    var _catProvider = Provider.of<CategoryProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: FutureBuilder<QuerySnapshot>(
          future: _service.products
              .orderBy('postedAt')
              .where('category', isEqualTo: _catProvider.selectedCategory)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(left: 140, right: 140),
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                  backgroundColor: Colors.grey.shade600,
                ),
              );
            }
            if (snapshot.data?.docs.length == 0) {
              return Container(
                height: MediaQuery.of(context).size.height,
                  child: Center(
                child: Text('No job openings available'),
              ));
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (proScreen == false)
                    Container(
                      height: 56,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'New Recommendations',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int i) {
                      var data = snapshot.data!.docs[i];
                      return ProductCard(data: data);
                    },
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
