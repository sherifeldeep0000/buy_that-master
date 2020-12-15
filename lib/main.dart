import 'package:buy_that/provider/admin_mode.dart';
import 'package:buy_that/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'provider/modelHud.dart';
import 'screens/admin/add_product.dart';
import 'screens/admin/admin_home.dart';
import 'screens/admin/manage_product.dart';
import 'screens/home_page.dart';
import 'screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          ManageProduct.id: (context) => ManageProduct(),
          EditProduct.id: (context) => EditProduct(),
        },
      ),
    );
  }
}
