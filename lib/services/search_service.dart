// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_page/search_page.dart';
import 'package:udyog/screens/product_list.dart';
import 'package:udyog/screens/subscreens/product_details_screen.dart';

class Products {
  final String title, description, category, time, company;
  final DocumentSnapshot document;

  Products(
      {required this.title,
      required this.description,
      required this.category,
      required this.time,
      required this.company,
      required this.document});
}

class SearchService {
  search({context, productList,provider}) {
    showSearch(
      context: context,
      delegate: SearchPage<Products>(
        onQueryUpdate: (s) => print(s),
        items: productList,
        searchLabel: 'Search jobs',
        suggestion: SingleChildScrollView(
          child: ProductList(true),
        ),
        failure: Center(
          child: Text('No jobs found :('),
        ),
        filter: (product) => [
          product.title,
          product.company,
          product.category,
        ],
        builder: (product) {
          var date =
              DateTime.fromMicrosecondsSinceEpoch(product.document['postedAt']);
          var _date = DateFormat.yMMMd().format(date);

          return InkWell(
            onTap: (){
              provider.getProductDetails(product.document);
              Navigator.pushReplacementNamed(context, ProductDetailsScreen.id);
            },
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 120,
                        child: Image.network(product.document['logourl']),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                product.company,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Posted At : $_date'),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.access_time_rounded),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: Text(product.time),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
