import 'dart:async';

import 'package:flutter/animation.dart';

class ReactionAnimation{
  dynamic state;
  ReactionAnimation({this.state});
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
    pushIconLikeUp = Tween(begin: 30.0, end: 60.0).animate(
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

    pushIconLoveUp = Tween(begin: 30.0, end: 60.0).animate(
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

    pushIconHahaUp = Tween(begin: 30.0, end: 60.0).animate(
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

    pushIconWowUp = Tween(begin: 30.0, end: 60.0).animate(
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

    pushIconSadUp = Tween(begin: 30.0, end: 60.0).animate(
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

    pushIconAngryUp = Tween(begin: 30.0, end: 60.0).animate(
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
    zoomBoxIcon =
        Tween(begin: 50.0, end: 40.0).animate(animControlIconWhenDrag);

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
    zoomBoxWhenDragOutside =
        Tween(begin: 40.0, end: 50.0).animate(animControlBoxWhenDragOutside);
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

  initAnimationReaction(){
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
  disposeAnimationReaction(){
    animControlBtnLongPress.dispose();
    animControlBox.dispose();
    animControlIconWhenDrag.dispose();
    animControlIconWhenDragInside.dispose();
    animControlIconWhenDragOutside.dispose();
    animControlBoxWhenDragOutside.dispose();
    animControlIconWhenRelease.dispose();
  }

}