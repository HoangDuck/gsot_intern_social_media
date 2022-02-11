import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media/core/converter/data_converter.dart';

popUpSharePost(BuildContext context, DataConvert dataConvert) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Stack(
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Share To!",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close_rounded,
                            color: Color(0xffff2B55),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xfff5f4f9),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEAEAEA),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEAEAEA),
                          ),
                        ),
                        hintText: 'Write comment',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 35,
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Your timeline",
                                style: TextStyle(
                                  color: Color(0xffadb2d0),
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xfff5f4f9)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          width: 90,
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "To friends",
                                style: TextStyle(
                                  color: Color(0xffadb2d0),
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xfff5f4f9)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          width: 90,
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Social Media",
                                style: TextStyle(
                                  color: Color(0xffadb2d0),
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xfff5f4f9)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: RaisedButton(
                        color: Color(0xffff2b55),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        child: Text(
                          "Publish",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
