import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/core/converter/data_converter.dart';
import 'package:social_media/core/model/posts.dart';
import 'package:social_media/core/model/user.dart';
import 'package:social_media/ui/constant/text_styles.dart';
import 'package:social_media/ui/widget/dottedline.dart';
import 'package:social_media/ui/widget/dropdown_menu_item_post.dart';
import 'package:social_media/ui/widget/fb_reaction_box.dart';
import 'package:social_media/ui/widget/share_post.dart';
import 'package:social_media/ui/widget/textform_comment.dart';

import 'comment_widget.dart';

class PostWidget extends StatefulWidget {
  final Post data;
  final User user;
  final DataConvert dataConvert;

  const PostWidget(
      {Key? key,
      required this.data,
      required this.user,
      required this.dataConvert})
      : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> with TickerProviderStateMixin {
  Offset? _tapPosition;
  bool _isShowCommentBox = false;

  late AnimationController expandController;

  late Animation<double> animation;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  @override
  void initState() {
    super.initState();
    _prepareAnimations();
  }

  void _runExpand() {
    if (_isShowCommentBox) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  void _prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 65.0,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: 55,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        widget.data.user!.picture.toString(),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.user!.name.toString(),
                        style: textSize20,
                      ),
                      Text(
                        widget.data.user!.nickname.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xff92929E),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        final RenderBox? overlay = Overlay.of(context)!
                            .context
                            .findRenderObject() as RenderBox;
                        showMenu(
                          color: Color(0xfff6f6f6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          context: context,
                          position: RelativeRect.fromRect(
                              _tapPosition! & const Size(30, 30),
                              // smaller rect, the touch area
                              Offset.zero &
                                  overlay!
                                      .size // Bigger rect, the entire screen
                              ),
                          items: [
                            PopupMenuItem(
                              onTap: () {
                                // int? idComment = comment.id;
                                // dataConvert.deleteDataComment(idPost!, idComment!);
                              },
                              child: dropdownMenuItemPost(
                                LineIcons.trash,
                                "Delete post",
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                // int? idComment = comment.id;
                                // dataConvert.deleteDataComment(idPost!, idComment!);
                              },
                              child: dropdownMenuItemPost(
                                LineIcons.ban,
                                "Hide post",
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                // int? idComment = comment.id;
                                // dataConvert.deleteDataComment(idPost!, idComment!);
                              },
                              child: dropdownMenuItemPost(
                                LineIcons.alternatePencil,
                                "Edit post",
                              ),
                            ),
                          ],
                        );
                      },
                      onTapDown: _storePosition,
                      child: Icon(Icons.more_horiz),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.data.content.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff92A0C7),
              ),
            ),
          ),
          Center(
            child: Image.network(
              widget.data.image.toString(),
              errorBuilder: (context, error, stacktrace) {
                if (widget.data.image.toString() == "") {
                  return Container();
                }
                return Image.file(
                  File(widget.data.image.toString()),
                  errorBuilder: (context, error, stacktrace) {
                    return Container();
                  },
                );
              },
            ),
          ),
          dottedLine(context),
          Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned(
                              child: Image(
                                width: 30,
                                image: AssetImage('assets/images/thumb.png'),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              child: Image(
                                width: 30,
                                image: AssetImage('assets/images/heart.png'),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              child: Image(
                                width: 30,
                                image: AssetImage('assets/images/smile.png'),
                              ),
                            ),
                            Positioned(
                              left: 60,
                              child: Image(
                                width: 30,
                                image: AssetImage('assets/images/weep.png'),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 95,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "10",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            LineIcons.commentDots,
                            color: Color(0xffadb2d0),
                          ),
                          Text(
                            "24 Comments",
                            style: TextStyle(
                              color: Color(0xffadb2d0),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: const [
                            Icon(
                              LineIcons.shareSquare,
                              color: Color(0xffadb2d0),
                            ),
                            Text(
                              "56 Shares",
                              style: TextStyle(
                                color: Color(0xffadb2d0),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 90,
                            child: TextButton(
                              onPressed: () {

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      LineIcons.heart,
                                      color: Color(0xffadb2d0),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Like",
                                      style:
                                          TextStyle(color: Color(0xffadb2d0)),
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xfff5f4f9)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            width: 110,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _isShowCommentBox = !_isShowCommentBox;
                                });
                                _runExpand();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      LineIcons.commentDots,
                                      color: Color(0xffadb2d0),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Comment",
                                      style:
                                          TextStyle(color: Color(0xffadb2d0)),
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                              onPressed: () {
                                popUpSharePost(context, widget.dataConvert);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      LineIcons.shareSquare,
                                      color: Color(0xffadb2d0),
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Share",
                                      style: TextStyle(
                                        color: Color(0xffadb2d0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xfff5f4f9)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: TextFormComment(),
          ),
          Comment(),
          Comment(),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: dottedLine(context),
          ),
        ],
      ),
    );
  }
}
