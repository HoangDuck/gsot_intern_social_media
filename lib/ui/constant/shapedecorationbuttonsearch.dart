import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Decoration shapeDecorationShadow(double durationCircular){
  double duration=0;
  duration=durationCircular;
  return ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(duration)),
      ),
      shadows:const [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 0.0,
          blurRadius: 20,
        ),
      ]
  );
}