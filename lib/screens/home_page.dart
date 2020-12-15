import 'dart:async';
import 'package:buy_that/colors.dart';
import 'package:buy_that/models/product.dart';
import 'package:buy_that/services/auth.dart';
import 'package:buy_that/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  final _store = store();
  int _bottomBarIndex = 0;
  List<Product> _products;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 3,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: kUnActiveColor,
              currentIndex: _bottomBarIndex,
              fixedColor: kMainColor,
              onTap: (value) {
                setState(() {
                  _tabBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text('test1'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('test2'),
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  title: Text('test3'),
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Colors.white,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'shirts',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex == 0 ? 16 : 8,
                    ),
                  ),
                  Text(
                    'jackets',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex == 1 ? 16 : 8,
                    ),
                  ),

                  Text(
                    'shoes',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : Colors.white,
                      fontSize: _tabBarIndex == 3 ? 16 : 8,
                    ),
                  ),
                ],
              ),
            ),
                                                                body: Container(color: Colors.blueAccent,
                                                                  child: TabBarView(             //Error in apppppppppppppppppppppppppppppppp
                                                                    children: <Widget>[
                                                                      shirtsView(),            //   must be that because stream builder
                                                                      productsView(kJackets, _products),
                                                                      productsView(kShoes, _products), // may be const for all category(products)
                                                                    ],
                                                                  ),
                                                                ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.add_shopping_cart)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  Widget shirtsView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            products.add(Product(
              pId: doc.documentID,
              pName: data[kProductName],
              pPrice: data[kProductPrice],
              pDescription: data[kProductDescription],
              pCategory: data[kProductCategory],
              pLocation: data[kProductLocation],
            ));
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(kShirts,_products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(products[index].pLocation),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.6,
                        child: Container(
                          width: MediaQuery.of(context).size.height,
                          height: 60,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                products[index].pName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('\$ ${products[index].pPrice}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }

  List<Product> getProductByCategory(String kShirts, List<Product>allproducts) {
    List<Product> products = [];
    try {
      for (var product in allproducts) {
        if (product.pCategory == kShirts) {
          products.add(product);
        }
      }
    } on Error catch (ex){
      print (ex);
    }
    return products;
  }

 Widget productsView(String pCategory, allproducts)
 {
   List<Product>products;
   products=getProductByCategory(pCategory,allproducts);
   return GridView.builder(
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 0.8,
     ),
     itemBuilder: (context, index) => Padding(
       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
       child: GestureDetector(
         child: Stack(
           children: <Widget>[
             Positioned.fill(
               child: Image(
                 fit: BoxFit.fill,
                 image: AssetImage(products[index].pLocation),
               ),
             ),
             Positioned(
               bottom: 0,
               child: Opacity(
                 opacity: 0.6,
                 child: Container(
                   width: MediaQuery.of(context).size.height,
                   height: 60,
                   color: Colors.white,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text(
                         products[index].pName,
                         style: TextStyle(fontWeight: FontWeight.bold),
                       ),
                       Text('\$ ${products[index].pPrice}'),
                     ],
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
     ),
     itemCount: products.length,
   );
 }


}
