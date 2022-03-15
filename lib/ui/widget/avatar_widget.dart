import 'package:flutter/material.dart';
import 'package:social_media/core/model/user.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/text_styles.dart';

Widget buildItemListAvatar(User data) {
  return SizedBox(
    width: 70.0,
    height: 60.0,
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: colorPopupWidget,
                image: DecorationImage(
                  image: NetworkImage(
                    data.picture.toString(),
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: IconButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {},
              ),
            ),
            Positioned(
              top: 35,
              left: 35,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 50,
          child: Text(
            data.name.toString(),
            textAlign: TextAlign.center,
            style: textSize14,
          ),
        )
      ],
    ),
  );
}
