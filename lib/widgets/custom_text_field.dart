import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onclick;
  String _errormessage(String str){
    switch(hint)
    {
      case 'Enter your name':return'name is empty!';
      case 'Enter your Email':return'email is empty!';
      case 'Enter your password':return'password is empty!';

    }
  }
  CustomTextField({@required this.hint, @required this.icon, @required this.onclick});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value)
      {
        if (value.isEmpty)
          {
            // ignore: missing_return
            return _errormessage(hint);
          }
      },
      onChanged: onclick,
      obscureText: hint =='Enter your password' ? true : false,
      cursorColor: Colors.deepPurple,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.amber,
        ),
        filled: true,
        fillColor: Colors.blue,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}