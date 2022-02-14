import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget greetingCard(){
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.yellow,
          width: 3,
        ),
      ),
      color: Color(0xfff5f4f9),
    ),
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Good Afternoon, Geogre Floyd",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xff4d4d59),
                ),
              ),
              Text(
                "May this afternoon belight, blesses, productive and happy for you",
                style: TextStyle(
                  color: Color(0xff9f92B5),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage('assets/images/good-noon.png'),
          ),
        ),
      ],
    ),
  );
}