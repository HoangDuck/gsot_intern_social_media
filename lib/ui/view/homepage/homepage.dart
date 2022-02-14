import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:social_media/core/converter/data_converter.dart';
import 'package:social_media/core/model/posts.dart';
import 'package:social_media/core/model/user.dart';

import 'package:social_media/ui/constant/text_styles.dart';

import 'package:social_media/ui/widget/avatar.dart';

import 'package:social_media/ui/widget/comment.dart';
import 'package:social_media/ui/widget/dottedline.dart';
import 'package:social_media/ui/widget/dropdown_menu_item_post.dart';
import 'package:social_media/ui/widget/fb_reaction_box.dart';
import 'package:social_media/ui/widget/greeting_card.dart';
import 'package:social_media/ui/widget/header_pagename.dart';
import 'package:social_media/ui/widget/share_post.dart';
import 'package:social_media/ui/widget/textform_comment.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListPosts();
  }
}

class ListAvatar extends StatefulWidget {
  const ListAvatar({Key? key}) : super(key: key);

  @override
  _ListAvatarState createState() => _ListAvatarState();
}

class _ListAvatarState extends State<ListAvatar> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 84.0,
      ),
      child: _buildSuggestions(),
    );
  }

  //build List avatars.
  Widget _buildSuggestions() {
    DataConvert dataConvert = Provider.of<DataConvert>(context);
    dataConvert.createListUsersAfterLogin();
    return ListView.builder(
      itemCount: dataConvert.listUsersAfterLogin.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        return buildItemListAvatar(dataConvert.listUsersAfterLogin[i]);
      },
    );
  }
}

class ListPosts extends StatefulWidget {
  const ListPosts({Key? key}) : super(key: key);

  @override
  _ListPostsState createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  Offset? _tapPosition;

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  Widget storiesHeaderCard() {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
        top: 45,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Color(0xffff2f64),
            child: Text(
              " ",
              style: TextStyle(fontSize: 22),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Stories",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert = Provider.of<DataConvert>(context);
    int length = dataConvert.listPosts.length;
    User user = dataConvert.currentUser;
    return ListView.builder(
      //increase 1 index because we have to add
      // a widget which includes some items for home page
      itemCount: dataConvert.listPosts.length + 1,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, i) {
        //before loading post this page have to load some items below.
        //such as: header page name, greeting card, list avatar
        //push back 1 index
        //if index =0 load items need to load before loading post
        //if greater 0 => load posts.
        if (i == 0) {
          return Column(
            children: [
              headerPageName("Home"),
              greetingCard(),
              storiesHeaderCard(),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: ListAvatar(),
              ),
            ],
          );
        }
        //minus 1 because list have been pushed back 1 index
        int index = i - 1;
        //build post list
        return _buildRow(
          dataConvert.listPosts[length - 1 - index], //reverse post index,
          // the newest post is the largest index
          user,
          dataConvert,
        );
      },
    );
  }

  Widget _buildRow(Post data, User user, DataConvert dataConvert) {
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
                        data.user!.picture.toString(),
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
                        data.user!.name.toString(),
                        style: textSize20,
                      ),
                      Text(
                        data.user!.nickname.toString(),
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
              data.content.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xff92A0C7),
              ),
            ),
          ),
          Center(
            child: Image.network(
              data.image.toString(),
              errorBuilder: (context, error, stacktrace) {
                if (data.image.toString() == "") {
                  return Container();
                }
                return Image.file(
                  File(data.image.toString()),
                  errorBuilder: (context, error, stacktrace) {
                    return Container();
                  },
                );
              },
            ),
          ),
          dottedLine(context),
          Stack(children: [
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
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FbReactionBox(),
                                ),
                              );
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
                                    style: TextStyle(color: Color(0xffadb2d0)),
                                  ),
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                            onPressed: () => {},
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
                                    style: TextStyle(color: Color(0xffadb2d0)),
                                  ),
                                ),
                              ],
                            ),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(5.0),
                            // ),
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
                        //Text(data.numberComments.toString(), style: textSize18Bold),
                        SizedBox(
                          height: 35,
                          width: 90,
                          child: TextButton(
                            onPressed: () {
                              popUpSharePost(context, dataConvert);
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
                              backgroundColor: MaterialStateProperty.all<Color>(
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
          ]),
          TextFormComment(),
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
