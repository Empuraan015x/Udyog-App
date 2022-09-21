// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_final_fields, unnecessary_string_escapes

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:udyog/forms/form_screen.dart';
import 'package:udyog/provider/product_provider.dart';
import 'package:intl/intl.dart';
import 'package:udyog/screens/chat/chatRoom.dart';
import 'package:udyog/screens/main_screen.dart';
import 'package:udyog/services/firebase_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

_launchURLBrowser() async {
  var url = Uri.parse("https://bit.ly/3BvA3kL");
  await launchUrl(url);
}

class ProductDetailsScreen extends StatefulWidget {
  static const String id = 'product-details-screen';

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  FirebaseService _service = FirebaseService();
  List fav = [];
  bool _isLiked = false;

  @override
  void didChangeDependencies() {
    var _productProvider = Provider.of<ProductProvider>(context);
    getFavourites(_productProvider);
    super.didChangeDependencies();
  }

  getFavourites(ProductProvider _productProvider) {
    _service.products.doc(_productProvider.productData.id).get().then((value) {
      setState(() {
        fav = value['favourites'];
      });
      if (fav.contains(_service.user!.uid)) {
        setState(() {
          _isLiked = true;
        });
      } else {
        setState(() {
          _isLiked = false;
        });
      }
    });
  }

  _callNumber() async {
    const number = '7012071215'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    var _productProvider = Provider.of<ProductProvider>(context);
    var data = _productProvider.productData;
    var date = DateTime.fromMicrosecondsSinceEpoch(data['postedAt']);
    var _date = DateFormat.yMMMd().format(date);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, MainScreen.id);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            padding: EdgeInsets.only(right: 248),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: Icon(
                _isLiked ? Icons.bookmark_outlined : Icons.bookmark_outlined),
            color: _isLiked ? Colors.blue : Colors.grey,
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
              });
              _service.updateFav(_isLiked, data.id, context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Image.network(data['logourl']),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data['company'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['title'],
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
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
                      data['address'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Icon(
                    Icons.access_time_filled_sharp,
                    color: Colors.lightBlue.shade300,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      data['time'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Posted at',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    _date,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Job Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(data['description']),
              SizedBox(
                height: 60,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_border_sharp,
                    color: Colors.lightBlue.shade300,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Experience',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data['experience'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.menu_book_sharp,
                    color: Colors.lightBlue.shade300,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Qualification',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data['qualification'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.money_sharp,
                    color: Colors.lightBlue.shade300,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Salary',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data['salary'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _productProvider.productData['selleruid'] ==
                          _service.user!.uid
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          height: 20,
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.grey.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, FormScreen.id);
                            },
                            child: Text('Edit Job'),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          height: 20,
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.grey.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, chatRoom.id);
                            },
                            child: Text('Chat'),
                          ),
                        ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    height: 20,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: _callNumber,
                      child: Text('Call'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'AD ID :${data['postedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Text(
                          'REPORT AD',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.warning_amber_sharp,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _productProvider.productData['selleruid'] == _service.user!.uid
                  ? Container()
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      height: 45,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: _launchURLBrowser,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Apply Now'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
