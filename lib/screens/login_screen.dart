import 'package:buy_that/colors.dart';
import 'package:buy_that/provider/admin_mode.dart';
import 'package:buy_that/provider/modelHud.dart';
import 'package:buy_that/screens/admin/admin_home.dart';
import 'package:buy_that/screens/home_page.dart';
import 'package:buy_that/screens/signup_screen.dart';
import 'package:buy_that/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buy_that/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
  bool isAdmin = false;
  final adminPassword = 'admin1234';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isloading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/icons8-buy-48.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          'buy it',
                          style: TextStyle(fontSize: 25, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  onclick: (value) {
                    _email = value;
                  },
                  hint: 'Enter your Email',
                  icon: Icons.email,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomTextField(
                  onclick: (value) {
                    _password = value;
                  },
                  hint: 'Enter your password',
                  icon: Icons.lock,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      _validate(context); //method validate()
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'you have an account?',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      'sign up',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Provider.of<AdminMode>(context,listen: false).changeIsAdmin(true);
                          },
                          child: Text(
                      'i am admin',
                      textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin?kMainColor:Colors.white
                            ),
                    ),
                        ),
                    ),
                    Expanded(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Provider.of<AdminMode>(context, listen: false).changeIsAdmin(false);
                          },
                          child: Text(
                              'i am user',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin?Colors.white:kMainColor
                          ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisloading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelhud.changeisloading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modelhud.changeisloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(' something wrong'),
          ));
        }
      } else {
        try {
          await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          modelhud.changeisloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeisloading(false);
  }
}
