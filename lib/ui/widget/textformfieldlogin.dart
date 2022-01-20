import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormFieldLoginRegisterPage(TextEditingController textEditingController,String labelText,bool obscureText){
  return TextFormField(
    controller: textEditingController,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder( //Outline border type for TextField
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),
    obscureText: obscureText,
  );
}