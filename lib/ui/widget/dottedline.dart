import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/cupertino.dart';

Widget dottedLine(BuildContext context){
  return Container(
    padding: EdgeInsets.only(top: 3, bottom: 2),
    child: FDottedLine(
      color: Color(0xffe2e2e2),
      width: MediaQuery.of(context).size.width,
      strokeWidth: 2.0,
      dottedLength: 5.0,
      space: 2.0,
    ),
  );
}