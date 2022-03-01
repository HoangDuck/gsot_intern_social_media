import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media/core/animation/expand_collapse_animation.dart';
import 'package:social_media/core/services/play_audio_services.dart';
import 'package:social_media/core/util/utils.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/app_images.dart';
import 'package:social_media/ui/widget/reaction_post_statistic_widget.dart';
import 'package:social_media/ui/widget/textform_comment.dart';

class Comment extends StatefulWidget {
  const Comment({Key? key}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> with TickerProviderStateMixin {
  //List reaction icons
  List<String> listReactionIcons=[];
  int numberOfReaction=0;
  //show comment box
  late ExpandCollapseAnimation expandCollapseAnimation;

  //time duration animation reaction icon button
  int durationAnimationBox = 500;
  int durationAnimationBtnLongPress = 250;
  int durationAnimationBtnShortPress = 500;
  int durationAnimationIconWhenDrag = 150;
  int durationAnimationIconWhenRelease = 1000;

  // For long press btn
  late AnimationController animControlBtnLongPress, animControlBox;
  late Animation zoomIconLikeInBtn, tiltIconLikeInBtn, zoomTextLikeInBtn;
  late Animation fadeInBox;
  late Animation moveRightGroupIcon;
  late Animation pushIconLikeUp,
      pushIconLoveUp,
      pushIconHahaUp,
      pushIconWowUp,
      pushIconSadUp,
      pushIconAngryUp;
  late Animation zoomIconLike,
      zoomIconLove,
      zoomIconHaha,
      zoomIconWow,
      zoomIconSad,
      zoomIconAngry;

  // For short press btn
  late AnimationController animControlBtnShortPress;
  late Animation zoomIconLikeInBtn2, tiltIconLikeInBtn2;

  // For zoom icon when drag
  late AnimationController animControlIconWhenDrag;
  late AnimationController animControlIconWhenDragInside;
  late AnimationController animControlIconWhenDragOutside;
  late AnimationController animControlBoxWhenDragOutside;
  late Animation zoomIconChosen, zoomIconNotChosen;
  late Animation zoomIconWhenDragOutside;
  late Animation zoomIconWhenDragInside;
  late Animation zoomBoxWhenDragOutside;
  late Animation zoomBoxIcon;

  // For jump icon when release
  late AnimationController animControlIconWhenRelease;
  late Animation zoomIconWhenRelease, moveUpIconWhenRelease;
  late Animation moveLeftIconLikeWhenRelease,
      moveLeftIconLoveWhenRelease,
      moveLeftIconHahaWhenRelease,
      moveLeftIconWowWhenRelease,
      moveLeftIconSadWhenRelease,
      moveLeftIconAngryWhenRelease;

  Duration durationLongPress = Duration(milliseconds: 250);
  late Timer holdTimer;
  bool isLongPress = false;
  bool isLiked = false;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int whichIconUserChoose = 0;
  int previousWhichIconUserChoose=0;
  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int currentIconFocus = 0;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;

  @override
  void initState() {
    super.initState();
    //fetch which icon user choose
    whichIconUserChoose=0;
    previousWhichIconUserChoose=whichIconUserChoose;
    //fetch number of reactions
    numberOfReaction=0;
    //fetch reaction icons list
    listReactionIcons.addAll([]);
    //init animation show comment box
    expandCollapseAnimation = ExpandCollapseAnimation(state: this);
    // Button Like
    initAnimationBtnLike();

    // Box and Icons
    initAnimationBoxAndIcons();

    // Icon when drag
    initAnimationIconWhenDrag();

    // Icon when drag outside
    initAnimationIconWhenDragOutside();

    // Box when drag outside
    initAnimationBoxWhenDragOutside();

    // Icon when first drag
    initAnimationIconWhenDragInside();

    // Icon when release
    initAnimationIconWhenRelease();
  }

  initAnimationBtnLike() {
    // long press
    animControlBtnLongPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
    tiltIconLikeInBtn =
        Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
    zoomTextLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

    zoomIconLikeInBtn.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn.addListener(() {
      setState(() {});
    });
    zoomTextLikeInBtn.addListener(() {
      setState(() {});
    });

    // short press
    animControlBtnShortPress = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 =
        Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 =
        Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationAnimationBox));

    // General
    moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 1.0)),
    );
    moveRightGroupIcon.addListener(() {
      setState(() {});
    });

    // Box
    fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.7, 1.0)),
    );
    fadeInBox.addListener(() {
      setState(() {});
    });

    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.0, 0.5),
      ),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.0, 0.5),
      ),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.1, 0.6),
      ),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.1, 0.6),
      ),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.2, 0.7),
      ),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.2, 0.7),
      ),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.3, 0.8),
      ),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.3, 0.8),
      ),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.4, 0.9),
      ),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.4, 0.9),
      ),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.5, 1.0),
      ),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animControlBox,
        curve: Interval(0.5, 1.0),
      ),
    );

    pushIconLikeUp.addListener(() {
      setState(() {});
    });
    zoomIconLike.addListener(() {
      setState(() {});
    });
    pushIconLoveUp.addListener(() {
      setState(() {});
    });
    zoomIconLove.addListener(() {
      setState(() {});
    });
    pushIconHahaUp.addListener(() {
      setState(() {});
    });
    zoomIconHaha.addListener(() {
      setState(() {});
    });
    pushIconWowUp.addListener(() {
      setState(() {});
    });
    zoomIconWow.addListener(() {
      setState(() {});
    });
    pushIconSadUp.addListener(() {
      setState(() {});
    });
    zoomIconSad.addListener(() {
      setState(() {});
    });
    pushIconAngryUp.addListener(() {
      setState(() {});
    });
    zoomIconAngry.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDrag() {
    animControlIconWhenDrag = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));

    zoomIconChosen =
        Tween(begin: 1.0, end: 1.8).animate(animControlIconWhenDrag);
    zoomIconNotChosen =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
    zoomBoxIcon =
        Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

    zoomIconChosen.addListener(() {
      setState(() {});
    });
    zoomIconNotChosen.addListener(() {
      setState(() {});
    });
    zoomBoxIcon.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragOutside() {
    animControlIconWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragOutside =
        Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
    zoomIconWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationBoxWhenDragOutside() {
    animControlBoxWhenDragOutside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomBoxWhenDragOutside =
        Tween(begin: 40.0, end: 40.0).animate(animControlBoxWhenDragOutside);
    zoomBoxWhenDragOutside.addListener(() {
      setState(() {});
    });
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  initAnimationIconWhenRelease() {
    animControlIconWhenRelease = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationAnimationIconWhenRelease));

    zoomIconWhenRelease = Tween(begin: 1.8, end: 0.0).animate(CurvedAnimation(
        parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveUpIconWhenRelease = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    moveLeftIconLikeWhenRelease = Tween(begin: 20.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconLoveWhenRelease = Tween(begin: 68.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconHahaWhenRelease = Tween(begin: 116.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconWowWhenRelease = Tween(begin: 164.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconSadWhenRelease = Tween(begin: 212.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));
    moveLeftIconAngryWhenRelease = Tween(begin: 260.0, end: 10.0).animate(
        CurvedAnimation(
            parent: animControlIconWhenRelease, curve: Curves.decelerate));

    zoomIconWhenRelease.addListener(() {
      setState(() {});
    });
    moveUpIconWhenRelease.addListener(() {
      setState(() {});
    });

    moveLeftIconLikeWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconLoveWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconHahaWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconWowWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconSadWhenRelease.addListener(() {
      setState(() {});
    });
    moveLeftIconAngryWhenRelease.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
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
                  CardComment(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        onTapDown: onTapDownBtn,
                        onTapUp: onTapUpBtn,
                        onTap: () {},
                        child: TextButton(
                          onPressed: () {
                            if (!isLongPress) {
                              setState(() {
                                if (whichIconUserChoose == 0) {
                                  isLiked = !isLiked;
                                } else {
                                  if (isLiked) {
                                    isLiked = !isLiked;
                                  }
                                  whichIconUserChoose = 0;
                                  previousWhichIconUserChoose=whichIconUserChoose;
                                  numberOfReaction--;
                                  listReactionIcons.removeAt(0);
                                }
                                if (isLiked) {
                                  PlayAudio.playSound('short_press_like.mp3');
                                  whichIconUserChoose = 1;
                                  previousWhichIconUserChoose=whichIconUserChoose;
                                  numberOfReaction++;
                                  listReactionIcons.insert(0, 'Like');
                                }
                              });
                            }
                          },
                          child: Container(
                            child: whichIconUserChoose == 0
                                ? Icon(
                                    LineIcons.heart,
                                    color: Color(0xffff2f64),
                                    size: 20,
                                  )
                                : Image.asset(
                                    getImageIconBtn(),
                                    width: 20.0,
                                    height: 20.0,
                                    fit: BoxFit.contain,
                                    color: getTintColorIconBtn(),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.7,
                bottom: 35,
                child: ReactionStatisticWidget(
                  listOfReactionsIcon: listReactionIcons,
                  numberReaction: numberOfReaction,
                ),
              ),
              Positioned(
                bottom: -100,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Stack(
                  children: <Widget>[
                    // Box
                    renderBox(),

                    // Icons
                    renderIcons(),
                  ],
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
          onHorizontalDragEnd: onHorizontalDragEndBoxIcon,
          onHorizontalDragUpdate: onHorizontalDragUpdateBoxIcon,
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: expandCollapseAnimation.animation,
          child: TextFormComment(),
        ),
      ],
    );
  }

  Widget renderBox() {
    return Opacity(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey.shade300, width: 0.3),
        ),
        width: 300.0,
        height: isDragging
            ? (previousIconFocus == 0 ? zoomBoxIcon.value : 30.0)
            : isDraggingOutside
                ? zoomBoxWhenDragOutside.value
                : 40.0,
        margin: EdgeInsets.only(bottom: 130.0, left: 10.0),
      ),
      opacity: fadeInBox.value,
    );
  }

  Widget renderIcons() {
    return Container(
      child: Row(
        children: <Widget>[
          // icon like
          Transform.scale(
            child: Container(
              child: Image.asset(
                ic_like_gif,
                width: 30.0,
                height: 30.0,
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(bottom: pushIconLikeUp.value),
              width: 30.0,
              height: currentIconFocus == 1 ? 50.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 1
                    ? zoomIconChosen.value
                    : (previousIconFocus == 1
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconLike.value,
          ),

          // icon love
          Transform.scale(
            child: Container(
              child: Image.asset(
                ic_heart_gif,
                width: 30.0,
                height: 30.0,
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(bottom: pushIconLoveUp.value),
              width: 30.0,
              height: currentIconFocus == 2 ? 50.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 2
                    ? zoomIconChosen.value
                    : (previousIconFocus == 2
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconLove.value,
          ),

          // icon haha
          Transform.scale(
            child: Container(
              child: Image.asset(
                ic_haha_gif,
                width: 30.0,
                height: 30.0,
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(bottom: pushIconHahaUp.value),
              width: 30.0,
              height: currentIconFocus == 3 ? 50.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 3
                    ? zoomIconChosen.value
                    : (previousIconFocus == 3
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconHaha.value,
          ),

          // icon wow
          Transform.scale(
            child: Container(
              child: Image.asset(
                ic_wow_gif,
                width: 30.0,
                height: 30.0,
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(bottom: pushIconWowUp.value),
              width: 30.0,
              height: currentIconFocus == 4 ? 50.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 4
                    ? zoomIconChosen.value
                    : (previousIconFocus == 4
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconWow.value,
          ),

          // icon sad
          Transform.scale(
            child: Container(
              child: Image.asset(
                ic_sad_gif,
                width: 30.0,
                height: 30.0,
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(bottom: pushIconSadUp.value),
              width: 30.0,
              height: currentIconFocus == 5 ? 50.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 5
                    ? zoomIconChosen.value
                    : (previousIconFocus == 5
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconSad.value,
          ),

          // icon angry
          Transform.scale(
            child: Container(
              child: Image.asset(
                ic_angry_gif,
                width: 30.0,
                height: 30.0,
                fit: BoxFit.contain,
              ),
              margin: EdgeInsets.only(bottom: pushIconAngryUp.value),
              width: 30.0,
              height: currentIconFocus == 6 ? 50.0 : 30.0,
            ),
            scale: isDragging
                ? (currentIconFocus == 6
                    ? zoomIconChosen.value
                    : (previousIconFocus == 6
                        ? zoomIconNotChosen.value
                        : isJustDragInside
                            ? zoomIconWhenDragInside.value
                            : 0.8))
                : isDraggingOutside
                    ? zoomIconWhenDragOutside.value
                    : zoomIconAngry.value,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      width: 300.0,
      height: 250.0,
      margin: EdgeInsets.only(left: moveRightGroupIcon.value, top: 65.0),
      // uncomment here to see area of draggable
      // color: Colors.amber.withOpacity(0.5),
    );
  }

  String getImageIconBtn() {
    if (!isDragging) {
      if (isLiked && whichIconUserChoose != 1) {
        isLiked = !isLiked;
      }
      return Utils.getPathIconReactionIndex(whichIconUserChoose);
    }
    return ic_thumb_up2;
  }

  Color? getTintColorIconBtn() {
    if (whichIconUserChoose == 1) {
      return Color(0xff558AFE);
    } else if (!isDragging && whichIconUserChoose != 0) {
      return null;
    } else {
      return colorButtonPost;
    }
  }

  void onHorizontalDragEndBoxIcon(DragEndDetails dragEndDetail) {
    isDragging = false;
    isDraggingOutside = false;
    isJustDragInside = true;
    previousIconFocus = 0;
    currentIconFocus = 0;

    onTapUpBtn(null);
  }

  void onHorizontalDragUpdateBoxIcon(DragUpdateDetails dragUpdateDetail) {
    // return if the drag is drag without press button
    if (!isLongPress) return;

    // the margin top the box is 150
    // and plus the height of toolbar and the status bar
    // so the range we check is about 200 -> 500

    if (dragUpdateDetail.globalPosition.dy >= 200 &&
        dragUpdateDetail.globalPosition.dy <=
            MediaQuery.of(context).size.height * 0.9) {
      isDragging = true;
      isDraggingOutside = false;

      if (isJustDragInside && !animControlIconWhenDragInside.isAnimating) {
        animControlIconWhenDragInside.reset();
        animControlIconWhenDragInside.forward();
      }

      if (dragUpdateDetail.globalPosition.dx >= 20 &&
          dragUpdateDetail.globalPosition.dx < 83) {
        if (currentIconFocus != 1) {
          handleWhenDragBetweenIcon(1);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 83 &&
          dragUpdateDetail.globalPosition.dx < 126) {
        if (currentIconFocus != 2) {
          handleWhenDragBetweenIcon(2);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 126 &&
          dragUpdateDetail.globalPosition.dx < 180) {
        if (currentIconFocus != 3) {
          handleWhenDragBetweenIcon(3);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 180 &&
          dragUpdateDetail.globalPosition.dx < 233) {
        if (currentIconFocus != 4) {
          handleWhenDragBetweenIcon(4);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 233 &&
          dragUpdateDetail.globalPosition.dx < 286) {
        if (currentIconFocus != 5) {
          handleWhenDragBetweenIcon(5);
        }
      } else if (dragUpdateDetail.globalPosition.dx >= 286 &&
          dragUpdateDetail.globalPosition.dx < 340) {
        if (currentIconFocus != 6) {
          handleWhenDragBetweenIcon(6);
        }
      }
    } else {
      whichIconUserChoose = 0;
      previousIconFocus = 0;
      currentIconFocus = 0;
      isJustDragInside = true;

      if (isDragging && !isDraggingOutside) {
        isDragging = false;
        isDraggingOutside = true;
        animControlIconWhenDragOutside.reset();
        animControlIconWhenDragOutside.forward();
        animControlBoxWhenDragOutside.reset();
        animControlBoxWhenDragOutside.forward();
      }
    }
  }

  void handleWhenDragBetweenIcon(int currentIcon) {
    PlayAudio.playSound('icon_focus.mp3');
    whichIconUserChoose = currentIcon;
    previousIconFocus = currentIconFocus;
    currentIconFocus = currentIcon;
    animControlIconWhenDrag.reset();
    animControlIconWhenDrag.forward();
  }

  void onTapDownBtn(TapDownDetails tapDownDetail) {
    holdTimer = Timer(durationLongPress, showBox);
  }

  void onTapUpBtn(TapUpDetails? tapUpDetail) {
    if (isLongPress) {
      if (whichIconUserChoose == 0) {
        PlayAudio.playSound('box_down.mp3');
        numberOfReaction--;
        if (previousWhichIconUserChoose == 0) {
          numberOfReaction++;
          return;
        }
        listReactionIcons.removeAt(0);
        previousWhichIconUserChoose = whichIconUserChoose;
      } else {
        PlayAudio.playSound('icon_choose.mp3');
        if (previousWhichIconUserChoose == 0) {
          numberOfReaction++;
          previousWhichIconUserChoose = whichIconUserChoose;
          listReactionIcons.insert(
              0, Utils.getTextReaction(whichIconUserChoose));
        } else {
          listReactionIcons.removeAt(0);
          listReactionIcons.insert(
              0, Utils.getTextReaction(whichIconUserChoose));
        }
      }
      Timer(Duration(milliseconds: durationAnimationBox), () {
        isLongPress = false;
      });

      holdTimer.cancel();

      animControlBtnLongPress.reverse();

      setReverseValue();
      animControlBox.reverse();

      animControlIconWhenRelease.reset();
      animControlIconWhenRelease.forward();
    }
  }

  void showBox() {
    PlayAudio.playSound('box_up.mp3');
    isLongPress = true;

    animControlBtnLongPress.forward();

    setForwardValue();
    animControlBox.forward();
  }

  // We need to set the value for reverse because if not
  // the angry-icon will be pulled down first, not the like-icon
  void setReverseValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
  }

  // When set the reverse value, we need set value to normal for the forward
  void setForwardValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: 50.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
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
