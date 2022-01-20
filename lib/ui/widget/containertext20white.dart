import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/ui/constant/text_styles.dart';

Widget containerTextWhiteLoginRegister(String text){
  return Container(
    color: Colors.blue,
    child: Center(
      child: Text(text,style: textWhite20),
    ),
  );
}