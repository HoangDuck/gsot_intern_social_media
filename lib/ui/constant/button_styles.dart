import 'package:flutter/material.dart';

final buttonStyleLogin=ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.deepPurple)
        )
    )
);