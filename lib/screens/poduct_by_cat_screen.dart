import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udyog/provider/cat_provider.dart';
import 'package:udyog/screens/product_list.dart';

class ProductByCategory extends StatelessWidget {
  static const String id = 'product-by-cat';

  const ProductByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Text(
          _catProvider.selectedCategory,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(

          child: ProductList(true),
        ),
      ),
    );
  }
}
