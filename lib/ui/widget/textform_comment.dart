import 'package:flutter/material.dart';
class TextFormComment extends StatefulWidget {
  const TextFormComment({Key? key}) : super(key: key);

  @override
  _TextFormCommentState createState() => _TextFormCommentState();
}

class _TextFormCommentState extends State<TextFormComment> {
  late TextEditingController textCommentEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xfff5f4f9),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEAEAEA),),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEAEAEA),),
              ),
              hintText: 'Write comment',
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                      });
                    },
                    icon: Icon(Icons.image),
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                      });
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
   super.initState();
   textCommentEditingController=TextEditingController();
  }
}
