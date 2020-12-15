import 'package:buy_that/colors.dart';
import 'package:buy_that/screens/admin/add_product.dart';
import 'package:buy_that/screens/admin/manage_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminHome extends StatelessWidget {
  static String id='AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: (){Navigator.pushNamed(context, AddProduct.id);},child: Text('Add Product'),),
            RaisedButton(onPressed: (){Navigator.pushNamed(context, ManageProduct.id);},child: Text('Edit Product'),),
            RaisedButton(onPressed: (){},child: Text('View Product'),),
          ],
        ),
      ),
    );
  }
}
