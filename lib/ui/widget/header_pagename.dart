import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget headerPageName(String pageName) {
  return SizedBox(
    height: 100,
    child: Stack(
      children: [
        Image(
          width: double.infinity,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/animate-bg.png'),
        ),
        Opacity(
          opacity: 0.9,
          child: Container(
            color: Color(0xffff2f64),
          ),
        ),
        Container(
          height: 100,
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Newsfeed",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: pageName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " / Newsfeed"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
