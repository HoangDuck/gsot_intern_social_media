import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Comment extends StatelessWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardComment(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                LineIcons.reply,
                color: Color(0xffff2f64),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                LineIcons.heart,
                color: Color(0xffff2f64),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
class CardComment extends StatelessWidget {
  const CardComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: CircleAvatar(
            radius: 30.0,
            //backgroundImage: NetworkImage(comment.user!.picture.toString()),
            backgroundColor: Color(0xfff5f4f9),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xfff5f4f9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        "comment.user!.name.toString()",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "time comment",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xffadb2d0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "comment.content.toString()",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffadb2d0),
                      ),
                    ),
                  ),
                  // Image.file(
                  //   File(comment.image.toString()),
                  //   errorBuilder: (context, error, stacktrace) {
                  //     return Container();
                  //   },
                  // )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

