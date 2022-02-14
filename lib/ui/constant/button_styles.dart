import 'package:flutter/material.dart';

final buttonStyleLogin=ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Color(0xffff2c55)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Color(0xffff2c55))
        )
    )
);