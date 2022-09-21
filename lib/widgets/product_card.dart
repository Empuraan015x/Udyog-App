// ignore_for_file: prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/product_provider.dart';
import 'package:udyog/screens/subscreens/product_details_screen.dart';
import 'package:udyog/services/firebase_services.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final QueryDocumentSnapshot<Object?> data;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  FirebaseService _service = FirebaseService();
  String address = '';
  late DocumentSnapshot sellerDetails;
  List fav = [];
  bool _isLiked = false;

  @override
  void initState() {
    getSellerData();
    getFavourites();
    super.initState();
  }

  getSellerData() {
    _service.getSellerData(widget.data['selleruid']).then((value) {
      if (mounted) {
        setState(() {
          address = value['address'];
          sellerDetails = value;
        });
      }
    });
  }

  getFavourites() {
    _service.products.doc(widget.data.id).get().then((value) {
      if (mounted) {
        setState(() {
          fav = value['favourites'];
        });
      }
      if (fav.contains(_service.user?.uid)) {
        if (mounted) {
          setState(() {
            _isLiked = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isLiked = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ProductProvider>(context);

    return InkWell(
      onTap: () {
        _provider.getProductDetails(widget.data);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailsScreen()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: Image.network(widget.data['logourl']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.data['company'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.data['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.work_outline_rounded,
                            color: Colors.lightBlue.shade300,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.data['vacancy'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'vacancy',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
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
                    Flexible(
                      child: Text(
                        widget.data['address'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0.0,
              child: IconButton(
                icon: Icon(_isLiked
                    ? Icons.bookmark_outlined
                    : Icons.bookmark_outlined),
                color: _isLiked ? Colors.blue : Colors.grey,
                onPressed: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                  _service.updateFav(_isLiked, widget.data.id, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
