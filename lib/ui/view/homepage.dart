import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:social_media/core/converter/data_converter.dart';
import 'package:social_media/core/model/user.dart';
import 'package:social_media/ui/constant/app_colors.dart';

import 'package:social_media/ui/widget/avatar_widget.dart';
import 'package:social_media/ui/widget/greeting_card.dart';
import 'package:social_media/ui/widget/header_pagename.dart';
import 'package:social_media/ui/widget/post_widget.dart';

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

  @override
  void initState() {
    super.initState();
    //call fetch api list post from api
    //call api get current user
    //call api get number of posts.
  }

  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert = Provider.of<DataConvert>(context); //api request
    int length = dataConvert.listPosts.length; //api get number of post
    User user = dataConvert.currentUser; //get current account user
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
        return length - 1 - index == 0//if this is the last post,
        // show the last post with circle loading animation
            ? Column(
                children: [
                  PostWidget(
                    data: dataConvert
                        .listPosts[length - 1 - index], //reverse post index,
                    // the newest post is the largest index
                    user: user,
                    dataConvert: dataConvert,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(
                      color: only_color,
                    ),
                  ),
                ],
              )
            : PostWidget(
                data: dataConvert
                    .listPosts[length - 1 - index], //reverse post index,
                // the newest post is the largest index
                user: user,
                dataConvert: dataConvert,
              );
      },
    );
  }

  Widget storiesHeaderCard() {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
        top: 45,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
