import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormFieldLoginRegister(
    BuildContext context,
    TextEditingController controller,
    bool obSecure,
    dynamic lineIcons,
    String hintText) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: TextFormField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        suffixIcon: Icon(
          lineIcons,
          color: Colors.white54,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.white,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.white,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: Colors.white,
          ),
        ),
      ),
      obscureText: obSecure,
    ),
  );
}
