import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class ExpandCollapseAnimation{
  //state object in stateful with TickerProviderStateMixin
  dynamic state;

  bool isExpanded = false;

  ExpandCollapseAnimation({this.state,this.isExpanded=false}){
    prepareAnimations();
  }

  late AnimationController expandController;

  late Animation<double> animation;

  //expand comment box
  void runExpand() {
    isExpanded=!isExpanded;
    if (isExpanded) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  //prepare animation for comment box
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: state,
      duration: Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}