
import 'package:buy_that/provider/modelHud.dart';
import 'package:buy_that/screens/home_page.dart';
import 'package:buy_that/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:buy_that/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'SignupScreen';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        color: Colors.deepOrange,
        inAsyncCall: Provider.of<ModelHud>(context).isloading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
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
                height: height * .1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomTextField(
                  hint: 'Enter your name',
                  icon: Icons.person,
                ),
              ),
              SizedBox(
                height: height * .02,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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


                      final modelhud = Provider.of<ModelHud>(context , listen: false);
                      modelhud.changeisloading(true);


                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final authResult =
                              await _auth.signUp(_email.trim(), _password.trim());

                          modelhud.changeisloading(false);

                          Navigator.pushNamed(context, HomePage.id);
                            }
                        on PlatformException catch (e) {

                          modelhud.changeisloading(false);

                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message),
                            ),
                          );
                        }
                      }
                      modelhud.changeisloading(false);
                    },
                    child: GestureDetector(
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
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
                    'do not have an account?',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    'sign in',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
