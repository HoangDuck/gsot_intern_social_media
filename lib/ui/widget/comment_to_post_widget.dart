import 'package:flutter/material.dart';
import 'package:social_media/ui/widget/comment_widget.dart';

class CommentToPostWidget extends StatefulWidget {
  const CommentToPostWidget({Key? key}) : super(key: key);

  @override
  _CommentToPostWidgetState createState() => _CommentToPostWidgetState();
}

class _CommentToPostWidgetState extends State<CommentToPostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Comment(),
        ListView.builder(
          itemCount: 2,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,i){
            return Comment();
          },
        ),
      ],
    );
  }
}
