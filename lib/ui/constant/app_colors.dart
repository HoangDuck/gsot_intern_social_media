import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
const LinearGradient colorPopupWidget = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
  Color(0xff9796F0),
  Color(0xffFBC7D4),
  ],
);
const LinearGradient colorTitleApp = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[
    Color(0xff002fff),
    Color(0xff00f4ff),
  ],
);
const Color colorBottomPost=Colors.lightBlueAccent;
const Color colorFilterNotifier=Colors.black54;
// const Paint color=LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: <Color>[
//     Color(0xff002fff),
//     Color(0xff00f4ff),
//   ],
// ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0)) as Paint;