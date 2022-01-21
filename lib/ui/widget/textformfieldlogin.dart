import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormFieldLoginRegisterPage(TextEditingController textEditingController,String labelText,bool obscureText,IconData icon){
  return TextFormField(
    controller: textEditingController,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.deepPurple,
      ),
      filled: true,
      fillColor: Colors.white,
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),

    ),
    obscureText: obscureText,
  );
}