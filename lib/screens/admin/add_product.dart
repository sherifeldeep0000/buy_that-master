import 'package:buy_that/models/product.dart';
import 'package:buy_that/services/store.dart';
import 'package:buy_that/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _location;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                    hint: 'product Name',
                    onclick: (value) {
                      _name = value;
                    }),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hint: 'product Price',
                    onclick: (value) {
                      _price = value;
                    }),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hint: 'product Description',
                    onclick: (value) {
                      _description = value;
                    }),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hint: 'product Category',
                    onclick: (value) {
                      _category = value;
                    }),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hint: 'product Location',
                    onclick: (value) {
                      _location = value;
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_globalKey.currentState.validate())
                    {
                      _globalKey.currentState.save();
                      _store.addProduct(Product(
                        pName: _name,
                        pPrice: _price,
                        pDescription: _description,
                        pCategory: _category,
                        pLocation: _location,
                      ));
                    }
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
