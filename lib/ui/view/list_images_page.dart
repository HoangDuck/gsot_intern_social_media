import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media/core/util/utils.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/text_styles.dart';
import 'package:social_media/ui/view/slider_images.dart';
import 'package:social_media/ui/widget/dottedline.dart';
import 'package:social_media/ui/widget/reaction_post_statistic_widget.dart';
import 'package:social_media/ui/widget/share_post.dart';

class ListImagePage extends StatefulWidget {
  const ListImagePage({Key? key}) : super(key: key);

  @override
  _ListImagePageState createState() => _ListImagePageState();
}

class _ListImagePageState extends State<ListImagePage> {
  //number of comments
  int numberOfComment = 0;

  //list reaction icon of this post
  List<String> listReactionIcons = [];
  int numberOfReaction = 0;

  //number of sharing
  int numberOfSharing = 0;

  //Scroll controller
  late ScrollController listImagesController;

  //number of images
  int numberOfImages = 0;

  //list images path string
  List<String> listImagePaths = [];

  //current post content
  dynamic currentPost = {};

  //current index
  int currentIndex = 0;

  _scrollListenerListImages() {
    if (listImagesController.position.pixels ==
        listImagesController.position.maxScrollExtent) {
      if (listImagePaths.length < numberOfImages) {
        setState(() {
          //currentIndex += 10;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //initate scroll controller
    listImagesController = ScrollController();
    listImagesController.addListener(() {
      _scrollListenerListImages();
    });
    //fetch number of images
    numberOfImages = 6;
    //fetch list path images
    listImagePaths.addAll([
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
      "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
      "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
      "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
    ]);
    //fetch number of sharing
    numberOfSharing = 0;
    //fetch number of reactions
    numberOfReaction = 0;
    //fetch number of sharing post
    numberOfSharing = 0;
    //fetch list reaction icons
    listReactionIcons.addAll([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listImagePaths.length + 1,
        scrollDirection: Axis.vertical,
        controller: listImagesController,
        itemBuilder: (context, i) {
          if (i == 0) {
            return pageHeader();
          }
          return Column(
            children: [
              showImageWidget(context, listImagePaths[i - 1]),
              dottedLine(context),
              Row(
                children: [
                  Expanded(
                    child: ReactionStatisticWidget(
                      listOfReactionsIcon: listReactionIcons,
                      numberReaction: numberOfReaction,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        LineIcons.commentDots,
                        color: colorButtonPost,
                      ),
                      Text(
                        "${Utils.formatNumberReaction(numberOfComment)} Comments",
                        style: TextStyle(
                          color: colorButtonPost,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          LineIcons.shareSquare,
                          color: colorButtonPost,
                        ),
                        Text(
                          "${Utils.formatNumberReaction(numberOfSharing)} Shares",
                          style: TextStyle(
                            color: colorButtonPost,
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
                      likeButton(),
                      commentButton(),
                      shareButton(),
                    ],
                  ),
                ),
              ),
              dottedLine(context),
            ],
          );
        },
      ),
    );
  }

  Widget showImageWidget(BuildContext context, String pathImage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SlideImages(),
          ),
        );
      },
      child: Image.network(
        pathImage,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stacktrace) {
          if (pathImage == "") {
            return Container();
          }
          return Image.file(
            File(pathImage),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stacktrace) {
              return Container();
            },
          );
        },
      ),
    );
  }

  Widget pageHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 5,
          ),
          child: Row(
            children: [
              SizedBox(
                height: 55,
                width: 55,
                child: CircleAvatar(
                  // radius: 30.0,
                  // backgroundImage: NetworkImage(
                  //   widget.data.user!.picture.toString(),
                  // ),
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    "https://storage.googleapis.com/support-kms-prod/ZAl1gIwyUsvfwxoW9ns47iJFioHXODBbIkrK",
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hoang Duc",
                        style: textSize20,
                      ),
                      Text(
                        "@duckute",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff92929A),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            "widget.data.content.toString()",
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xff92929A),
            ),
          ),
        ),
        dottedLine(context),
        Row(
          children: [
            Expanded(
              child: ReactionStatisticWidget(
                listOfReactionsIcon: listReactionIcons,
                numberReaction: numberOfReaction,
              ),
            ),
            Row(
              children: [
                Icon(
                  LineIcons.commentDots,
                  color: colorButtonPost,
                ),
                Text(
                  "${Utils.formatNumberReaction(numberOfComment)} Comments",
                  style: TextStyle(
                    color: colorButtonPost,
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(
                    LineIcons.shareSquare,
                    color: colorButtonPost,
                  ),
                  Text(
                    "${Utils.formatNumberReaction(numberOfSharing)} Shares",
                    style: TextStyle(
                      color: colorButtonPost,
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
                likeButton(),
                commentButton(),
                shareButton(),
              ],
            ),
          ),
        ),
        dottedLine(context),
      ],
    );
  }

  Widget likeButton() {
    return GestureDetector(
      // onTapDown: onTapDownBtn,
      // onTapUp: onTapUpBtn,
      child: SizedBox(
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
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  getTextBtn(),
                  style: TextStyle(
                    color: getColorTextBtn(),
                  ),
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(colorBackGroundButtonPost),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget shareButton() {
    return SizedBox(
      height: 35,
      width: 90,
      child: TextButton(
        onPressed: () {
          popUpSharePost(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                LineIcons.shareSquare,
                color: colorButtonPost,
                size: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Share",
                style: TextStyle(
                  color: colorButtonPost,
                ),
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(colorBackGroundButtonPost),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget commentButton() {
    return SizedBox(
      height: 35,
      width: 110,
      child: TextButton(
        onPressed: () {
          setState(() {
            //expandCollapseAnimation.runExpand();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                LineIcons.commentDots,
                color: colorButtonPost,
                size: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Comment",
                style: TextStyle(color: colorButtonPost),
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(colorBackGroundButtonPost),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ),
    );
  }

  String getTextBtn() {
    // if (isDragging) {
    //   return 'Like';
    // }
    return Utils.getTextReaction(0);
  }

  Color getColorTextBtn() {
    // if (!isDragging) {
    //   //if button is liked and user choose other reaction icon set isLiked to false
    //   if (isLiked && whichIconUserChoose != 1) {
    //     isLiked = !isLiked;
    //   }
    //   return UtilsFeatured.colorTextReactionButton(whichIconUserChoose);
    // } else {
    return colorButtonPost;
    // }
  }
}
