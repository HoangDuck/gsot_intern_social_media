import 'package:flutter/cupertino.dart';

Widget dropdownMenuItemPost(dynamic lineIcons,String nameMenuItem){
  return Row(
    children: [
      Icon(
        lineIcons,
        color: Color(0xff92929A),
      ),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            nameMenuItem,
            style: TextStyle(
              color: Color(0xff92929A),
            ),
          ),
        ),
      )
    ],
  );
}