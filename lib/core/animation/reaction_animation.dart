import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/services/play_audio_services.dart';
import 'package:social_media/core/util/utils.dart';
import 'package:social_media/core/util/utils_featured.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/app_images.dart';
import 'package:social_media/ui/constant/icon_reactions.dart';

class ReactionAnimation {
  dynamic state;
  BuildContext context;
  bool isPost;

  ReactionAnimation(this.context, {this.state, this.isPost = true}) {
    initAnimationReaction();
  }

  //is display reaction box
  bool displayed = false;

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
  int previousWhichIconUserChoose = 0;

  // 0 = nothing, 1 = like, 2 = love, 3 = haha, 4 = wow, 5 = sad, 6 = angry
  int currentIconFocus = 0;
  int previousIconFocus = 0;
  bool isDragging = false;
  bool isDraggingOutside = false;
  bool isJustDragInside = true;

  //size icon
  double sizeIconUp = 60;
  double sizeIconZoomMax = 50;
  double sizeIconZoomMin = 40;

  initAnimationBtnLike() {
    // long press
    animControlBtnLongPress = AnimationController(
        vsync: state,
        duration: Duration(milliseconds: durationAnimationBtnLongPress));
    zoomIconLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);
    tiltIconLikeInBtn =
        Tween(begin: 0.0, end: 0.2).animate(animControlBtnLongPress);
    zoomTextLikeInBtn =
        Tween(begin: 1.0, end: 0.85).animate(animControlBtnLongPress);

    zoomIconLikeInBtn.addListener(() {
      state.setState(() {});
    });
    tiltIconLikeInBtn.addListener(() {
      state.setState(() {});
    });
    zoomTextLikeInBtn.addListener(() {
      state.setState(() {});
    });

    // short press
    animControlBtnShortPress = AnimationController(
        vsync: state,
        duration: Duration(milliseconds: durationAnimationBtnShortPress));
    zoomIconLikeInBtn2 =
        Tween(begin: 1.0, end: 0.2).animate(animControlBtnShortPress);
    tiltIconLikeInBtn2 =
        Tween(begin: 0.0, end: 0.8).animate(animControlBtnShortPress);

    zoomIconLikeInBtn2.addListener(() {
      state.setState(() {});
    });
    tiltIconLikeInBtn2.addListener(() {
      state.setState(() {});
    });
  }

  initAnimationBoxAndIcons() {
    animControlBox = AnimationController(
        vsync: state, duration: Duration(milliseconds: durationAnimationBox));

    // General
    moveRightGroupIcon = Tween(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 1.0)),
    );
    moveRightGroupIcon.addListener(() {
      state.setState(() {});
    });

    // Box
    fadeInBox = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.7, 1.0)),
    );
    fadeInBox.addListener(() {
      state.setState(() {});
    });

    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: sizeIconUp).animate(
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

    pushIconLoveUp = Tween(begin: 30.0, end: sizeIconUp).animate(
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

    pushIconHahaUp = Tween(begin: 30.0, end: sizeIconUp).animate(
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

    pushIconWowUp = Tween(begin: 30.0, end: sizeIconUp).animate(
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

    pushIconSadUp = Tween(begin: 30.0, end: sizeIconUp).animate(
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

    pushIconAngryUp = Tween(begin: 30.0, end: sizeIconUp).animate(
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
      state.setState(() {});
    });
    zoomIconLike.addListener(() {
      state.setState(() {});
    });
    pushIconLoveUp.addListener(() {
      state.setState(() {});
    });
    zoomIconLove.addListener(() {
      state.setState(() {});
    });
    pushIconHahaUp.addListener(() {
      state.setState(() {});
    });
    zoomIconHaha.addListener(() {
      state.setState(() {});
    });
    pushIconWowUp.addListener(() {
      state.setState(() {});
    });
    zoomIconWow.addListener(() {
      state.setState(() {});
    });
    pushIconSadUp.addListener(() {
      state.setState(() {});
    });
    zoomIconSad.addListener(() {
      state.setState(() {});
    });
    pushIconAngryUp.addListener(() {
      state.setState(() {});
    });
    zoomIconAngry.addListener(() {
      state.setState(() {});
    });
  }

  initAnimationIconWhenDrag() {
    animControlIconWhenDrag = AnimationController(
        vsync: state,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));

    zoomIconChosen =
        Tween(begin: 1.0, end: 1.8).animate(animControlIconWhenDrag);
    zoomIconNotChosen =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDrag);
    zoomBoxIcon = Tween(begin: sizeIconZoomMax, end: sizeIconZoomMin)
        .animate(animControlIconWhenDrag);

    zoomIconChosen.addListener(() {
      state.setState(() {});
    });
    zoomIconNotChosen.addListener(() {
      state.setState(() {});
    });
    zoomBoxIcon.addListener(() {
      state.setState(() {});
    });
  }

  initAnimationIconWhenDragOutside() {
    animControlIconWhenDragOutside = AnimationController(
        vsync: state,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragOutside =
        Tween(begin: 0.8, end: 1.0).animate(animControlIconWhenDragOutside);
    zoomIconWhenDragOutside.addListener(() {
      state.setState(() {});
    });
  }

  initAnimationBoxWhenDragOutside() {
    animControlBoxWhenDragOutside = AnimationController(
        vsync: state,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomBoxWhenDragOutside = Tween(begin: sizeIconZoomMin, end: sizeIconZoomMax)
        .animate(animControlBoxWhenDragOutside);
    zoomBoxWhenDragOutside.addListener(() {
      state.setState(() {});
    });
  }

  initAnimationIconWhenDragInside() {
    animControlIconWhenDragInside = AnimationController(
        vsync: state,
        duration: Duration(milliseconds: durationAnimationIconWhenDrag));
    zoomIconWhenDragInside =
        Tween(begin: 1.0, end: 0.8).animate(animControlIconWhenDragInside);
    zoomIconWhenDragInside.addListener(() {
      state.setState(() {});
    });
    animControlIconWhenDragInside.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isJustDragInside = false;
      }
    });
  }

  initAnimationIconWhenRelease() {
    animControlIconWhenRelease = AnimationController(
        vsync: state,
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
      state.setState(() {});
    });
    moveUpIconWhenRelease.addListener(() {
      state.setState(() {});
    });

    moveLeftIconLikeWhenRelease.addListener(() {
      state.setState(() {});
    });
    moveLeftIconLoveWhenRelease.addListener(() {
      state.setState(() {});
    });
    moveLeftIconHahaWhenRelease.addListener(() {
      state.setState(() {});
    });
    moveLeftIconWowWhenRelease.addListener(() {
      state.setState(() {});
    });
    moveLeftIconSadWhenRelease.addListener(() {
      state.setState(() {});
    });
    moveLeftIconAngryWhenRelease.addListener(() {
      state.setState(() {});
    });
  }

  initAnimationReaction() {
    //determine size of reaction widget
    if (isPost) {
      sizeIconUp = 60;
      sizeIconZoomMax = 50;
      sizeIconZoomMin = 40;
    } else {
      sizeIconUp = 50;
      sizeIconZoomMax = 40;
      sizeIconZoomMin = 30;
    }
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

  disposeAnimationReaction() {
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
  }

  void shortPressLikeButton() {
    if (!isLongPress) {
      state.setState(() {
        if (whichIconUserChoose == 0) {
          isLiked = !isLiked;
        } else {
          if (isLiked) {
            isLiked = !isLiked;
          }
          whichIconUserChoose = 0;
          previousWhichIconUserChoose = whichIconUserChoose;
          state.numberOfReaction--;
          state.listReactionIcons.removeAt(0);
        }
        if (isLiked) {
          PlayAudio.playSound('short_press_like.mp3');
          whichIconUserChoose = 1;
          previousWhichIconUserChoose = whichIconUserChoose;
          state.numberOfReaction++;
          state.listReactionIcons.insert(0, 'Like');
        }
      });
    }
  }

  void outTapReactionBox() {
    displayed = false;
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
            ? (previousIconFocus == 0
                ? zoomBoxIcon.value
                : isPost
                    ? 40.0
                    : 30.0)
            : isDraggingOutside
                ? zoomBoxWhenDragOutside.value
                : isPost
                    ? 50.0
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
          transformIconWidget('Like', pushIconLikeUp, zoomIconLike),
          // icon love
          transformIconWidget('Love', pushIconLoveUp, zoomIconLove),
          // icon haha
          transformIconWidget('Haha', pushIconHahaUp, zoomIconHaha),
          // icon wow
          transformIconWidget('Wow', pushIconWowUp, zoomIconWow),
          // icon sad
          transformIconWidget('Sad', pushIconSadUp, zoomIconSad),
          // icon angry
          transformIconWidget('Angry', pushIconAngryUp, zoomIconAngry),
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

  Widget transformIconWidget(
      String reactionText, Animation animationPushIconUp, Animation zoomIcon) {
    return Transform.scale(
      child: Container(
        child: Column(
          children: <Widget>[
            isPost
                ? currentIconFocus == listIconReactionsId[reactionText]
                    ? Container(
                        child: Text(
                          reactionText,
                          style: TextStyle(fontSize: 8.0, color: Colors.white),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        padding: EdgeInsets.only(
                            left: 7.0, right: 7.0, top: 2.0, bottom: 2.0),
                        margin: EdgeInsets.only(bottom: 8.0),
                      )
                    : Container()
                : Container(),
            GestureDetector(
              onTap: () {
                whichIconUserChoose = listIconReactionsId[reactionText];
                onTapIconReaction();
              },
              child: Image.asset(
                listIconReactionsImage[reactionText],
                width: isPost ? 40.0 : 30.0,
                height: isPost ? 40.0 : 30.0,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: animationPushIconUp.value),
        width: isPost ? 40.0 : 30.0,
        height: currentIconFocus == listIconReactionsId[reactionText]
            ? (isPost ? 70.0 : 30.0)
            : (isPost ? 40.0 : 30.0),
      ),
      scale: isDragging
          ? (currentIconFocus == listIconReactionsId[reactionText]
              ? zoomIconChosen.value
              : (previousIconFocus == listIconReactionsId[reactionText]
                  ? zoomIconNotChosen.value
                  : isJustDragInside
                      ? zoomIconWhenDragInside.value
                      : 0.8))
          : isDraggingOutside
              ? zoomIconWhenDragOutside.value
              : zoomIcon.value,
    );
  }

  void onTapIconReaction() {
    PlayAudio.playSound('icon_choose.mp3');
    if (previousWhichIconUserChoose == 0) {
      state.numberOfReaction++;
      previousWhichIconUserChoose = whichIconUserChoose;
      state.listReactionIcons
          .insert(0, Utils.getTextReaction(whichIconUserChoose));
    } else {
      state.listReactionIcons.removeAt(0);
      state.listReactionIcons
          .insert(0, Utils.getTextReaction(whichIconUserChoose));
    }
    displayed = false;
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

  String getTextBtn() {
    if (isDragging) {
      return 'Like';
    }
    return Utils.getTextReaction(whichIconUserChoose);
  }

  Color getColorTextBtn() {
    if (!isDragging) {
      //if button is liked and user choose other reaction icon set isLiked to false
      if (isLiked && whichIconUserChoose != 1) {
        isLiked = !isLiked;
      }
      return UtilsFeatured.colorTextReactionButton(whichIconUserChoose);
    } else {
      return colorButtonPost;
    }
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
    displayed = true;
    holdTimer = Timer(durationLongPress, showBox);
  }

  void onTapUpBtn(TapUpDetails? tapUpDetail) {
    if (isLongPress) {
      if (whichIconUserChoose == 0) {
        PlayAudio.playSound('box_down.mp3');
        state.numberOfReaction--;
        if (previousWhichIconUserChoose == 0) {
          state.numberOfReaction++;
          return;
        }
        state.listReactionIcons.removeAt(0);
        previousWhichIconUserChoose = whichIconUserChoose;
      } else {
        PlayAudio.playSound('icon_choose.mp3');
        if (previousWhichIconUserChoose == 0) {
          state.numberOfReaction++;
          previousWhichIconUserChoose = whichIconUserChoose;
          state.listReactionIcons
              .insert(0, Utils.getTextReaction(whichIconUserChoose));
        } else {
          state.listReactionIcons.removeAt(0);
          state.listReactionIcons
              .insert(0, Utils.getTextReaction(whichIconUserChoose));
        }
      }
      displayed = false;
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
    pushIconLikeUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
  }

  // When set the reverse value, we need set value to normal for the forward
  void setForwardValue() {
    // Icons
    pushIconLikeUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );
    zoomIconLike = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.0, 0.5)),
    );

    pushIconLoveUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );
    zoomIconLove = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.1, 0.6)),
    );

    pushIconHahaUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );
    zoomIconHaha = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.2, 0.7)),
    );

    pushIconWowUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );
    zoomIconWow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.3, 0.8)),
    );

    pushIconSadUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );
    zoomIconSad = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.4, 0.9)),
    );

    pushIconAngryUp = Tween(begin: 30.0, end: sizeIconUp).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
    zoomIconAngry = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animControlBox, curve: Interval(0.5, 1.0)),
    );
  }
}
