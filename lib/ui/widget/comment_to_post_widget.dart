import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/ui/widget/comment_widget.dart';

class CommentToPostWidget extends StatefulWidget {
  dynamic contentOfComment;

  CommentToPostWidget({Key? key, required this.contentOfComment})
      : super(key: key);

  @override
  CommentToPostWidgetState createState() => CommentToPostWidgetState();
}

class CommentToPostWidgetState extends State<CommentToPostWidget> {
  List<Widget> listCommentReplyWidgets = [];
  List<dynamic> listRepliesData = [];
  int numberOfCommentReply = 0;

  @override
  void initState() {
    super.initState();
    //fetch number of replies
    numberOfCommentReply = 0;
    //fetch two first replies of comment
    listRepliesData = [];
  }

  void addReply(dynamic reply) {
    numberOfCommentReply++;
    listRepliesData.add(reply);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Comment(
            contentOfComment: widget.contentOfComment,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              children: listRepliesWidgetLoad(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              bottom: 10,
            ),
            child: loadMoreComment(),
          ),
        ],
      ),
    );
  }

  List<Widget> listRepliesWidgetLoad() {
    listCommentReplyWidgets.clear();
    for (final element in listRepliesData) {
      listCommentReplyWidgets.add(
        Comment(
          contentOfComment: element,
        ),
      );
    }
    return listCommentReplyWidgets;
  }

  Widget loadMoreComment() {
    if (numberOfCommentReply > 2 &&
        listCommentReplyWidgets.length < numberOfCommentReply) {
      return GestureDetector(
        onTap: () {
          setState(() {
            listRepliesData.add(4);
          });
        },
        child: Text(
          "Load more replies...",
          style: TextStyle(
            color: Color(0xffFF2B55),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Container();
  }
}
