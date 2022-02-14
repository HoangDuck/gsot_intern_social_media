import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget iconCircleSocialMedia(dynamic lineIcons,Color color) {
  return CircleAvatar(
    radius: 20,
    backgroundColor: color,
    child: IconButton(
      color: Colors.white,
      icon: Icon(lineIcons),
      onPressed: () {},
    ),
  );
}
