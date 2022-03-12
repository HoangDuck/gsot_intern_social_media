import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media/core/animation/expand_collapse_animation.dart';
import 'package:social_media/core/animation/reaction_animation.dart';
import 'package:social_media/ui/constant/constant_reaction_icon_size.dart';
import 'package:social_media/ui/widget/reaction_post_statistic_widget.dart';
import 'package:social_media/ui/widget/show_full_image_widget.dart';
import 'package:social_media/ui/widget/textform_comment.dart';

class Comment extends StatefulWidget {
  dynamic contentOfComment;

  Comment({Key? key, required this.contentOfComment}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> with TickerProviderStateMixin {
  //List reaction icons
  List<String> listReactionIcons = [];
  int numberOfReaction = 0;

  //show comment box
  late ExpandCollapseAnimation expandCollapseAnimation;
  //animation reaction button
  late ReactionAnimation reactionAnimation;

  @override
  void initState() {
    super.initState();
    //init animation show comment box
    expandCollapseAnimation = ExpandCollapseAnimation(state: this);
    //fetch number of reactions
    numberOfReaction = 0;
    //fetch reaction icons list
    listReactionIcons.addAll([]);
    //fetch which icon user choose
    //init reaction animation
    reactionAnimation=ReactionAnimation(context,state: this);
    reactionAnimation.whichIconUserChoose = 0;
    reactionAnimation.previousWhichIconUserChoose = reactionAnimation.whichIconUserChoose;
  }
  @override
  void dispose() {
    super.dispose();
    reactionAnimation.disposeAnimationReaction();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Stack(
            children: [
              Column(
                children: [
                  CardComment(
                    contentOfComment: widget.contentOfComment,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expandCollapseAnimation.runExpand();
                            });
                          },
                          child: Icon(
                            LineIcons.reply,
                            color: Color(0xffff2f64),
                          ),
                        ),
                        GestureDetector(
                          onTapDown: reactionAnimation.onTapDownBtn,
                          onTapUp: reactionAnimation.onTapUpBtn,
                          child: TextButton(
                            onPressed: reactionAnimation.shortPressLikeButton,
                            child: Container(
                              child: reactionAnimation.whichIconUserChoose == 0
                                  ? Icon(
                                      LineIcons.heart,
                                      color: Color(0xffff2f64),
                                      size: 20,
                                    )
                                  : Image.asset(
                                reactionAnimation.getImageIconBtn(),
                                      width: 20.0,
                                      height: 20.0,
                                      fit: BoxFit.contain,
                                      color: reactionAnimation.getTintColorIconBtn(),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.7,
                bottom: 35,
                child: ReactionStatisticWidget(
                  listOfReactionsIcon: listReactionIcons,
                  numberReaction: numberOfReaction,
                  icon_size: icon_size_small,
                ),
              ),
              Positioned(
                bottom: -100,
                child: Stack(
                  children: <Widget>[
                    // Box
                    reactionAnimation.renderBox(),

                    // Icons
                    reactionAnimation.renderIcons(),
                  ],
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
          onHorizontalDragEnd: reactionAnimation.onHorizontalDragEndBoxIcon,
          onHorizontalDragUpdate: reactionAnimation.onHorizontalDragUpdateBoxIcon,
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: expandCollapseAnimation.animation,
          child: TextFormComment(),
        ),
      ],
    );
  }

}

class CardComment extends StatelessWidget {
  dynamic contentOfComment;

  CardComment({Key? key, required this.contentOfComment}) : super(key: key);

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
            backgroundImage: NetworkImage(
                "https://static.wikia.nocookie.net/rezero/images/0/02/Rem_Anime.png/revision/latest?cb=20210916151323"),
            backgroundColor: Color(0xfff5f4f9),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contentOfComment['content'].toString() != ""
                ? Container(
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
                            children: [
                              Text(
                                "${contentOfComment['name']}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${contentOfComment['time']}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff92929A),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.8,
                            ),
                            child: Text(
                              "${contentOfComment['content']}",
                              style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff92929A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${contentOfComment['name']}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${contentOfComment['time']}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff92929A),
                          ),
                        ),
                      ],
                    ),
                  ),
            contentOfComment['content'].toString() != "" &&
                    contentOfComment['image'] != ""
                ? SizedBox(
                    height: 5,
                  )
                : Container(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowFullImageWidget(
                      pathImage: contentOfComment['image'],
                    ),
                  ),
                );
              },
              child: Image.network(
                contentOfComment['image'],
                errorBuilder: (context, error, stacktrace) {
                  if (contentOfComment['image'] == "") {
                    return Container();
                  }
                  return Image.file(
                    File("${contentOfComment['image']}"),
                    errorBuilder: (context, error, stacktrace) {
                      return Container();
                    },
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width * 0.4,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
