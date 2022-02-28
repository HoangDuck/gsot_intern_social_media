import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/ui/widget/comment_widget.dart';

class CommentToPostWidget extends StatefulWidget {
  const CommentToPostWidget({Key? key}) : super(key: key);

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

  void addReply() {
    numberOfCommentReply++;
    listRepliesData.add(4);
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
          Comment(),
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
      listCommentReplyWidgets.add(Comment());
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
