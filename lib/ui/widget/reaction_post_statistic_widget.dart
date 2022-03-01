import 'package:flutter/material.dart';
import 'package:social_media/core/util/utils.dart';
import 'package:social_media/ui/constant/constant_reaction_icon_size.dart';

class ReactionStatisticWidget extends StatelessWidget {
  List<String> listOfReactionsIcon = [];
  List<String> listOfReactionsIconDisplay = [];

  //this field false is number of reaction hasn't appeared yet
  //this field true is number of reaction has appeared
  bool isLikeNumber = false;
  int numberReaction;
  dynamic icon_size;

  ReactionStatisticWidget(
      {Key? key,
      required this.listOfReactionsIcon,
      required this.numberReaction,
      this.icon_size = icon_size_big})
      : super(key: key);

  void resizeListIconReaction() {
    listOfReactionsIconDisplay.addAll(listOfReactionsIcon.toSet().toList());
    if (listOfReactionsIconDisplay.length > 3) {
      var tempList = listOfReactionsIconDisplay.sublist(0, 3);
      listOfReactionsIconDisplay.clear();
      listOfReactionsIconDisplay.addAll(tempList);
    }
  }

  @override
  Widget build(BuildContext context) {
    resizeListIconReaction();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          //these positioned widget check the list at
          // index has an item, if it doesn't have any item they will have
          // container widget
          Positioned(
            child: _widgetReturnIcon(0),
          ),
          Positioned(
            left: icon_size['position'][0],
            child: _widgetReturnIcon(1),
          ),
          Positioned(
            left: icon_size['position'][1],
            child: _widgetReturnIcon(2),
          ),
          Positioned(
            left: icon_size['position'][2],
            child: _widgetReturnIcon(3),
          ),
        ],
      ),
    );
  }

  Widget _widgetReturnIcon(int index) {
    if (checkDataIconList(index)) {
      return Image(
        width: icon_size['icon_size'],
        image: AssetImage(
          Utils.getPathIconReaction(
            listOfReactionsIconDisplay[index],
          ),
        ),
      );
    }
    if (!isLikeNumber) {
      isLikeNumber = true;
      return Container(
        padding: EdgeInsets.only(
          left: 5,
          top: 2,
        ),
        child: Text(
          Utils.formatNumberReaction(numberReaction),
          style: TextStyle(
            fontSize: icon_size['number_size'],
          ),
        ),
      );
    }
    return Container();
  }

  //this function check list item is existed at the specified index
  //if there is no item at the index, this function will return false
  //if there is an item at the index, this function will return true
  bool checkDataIconList(int index) {
    try {
      listOfReactionsIconDisplay[index];
      return true;
    } catch (e) {
      //if there is no element at index 0 that means this post has no reaction
      //The post has no reaction, it doesn't need to appear number of reaction widget
      //so set isLikeNumber = true to not appear
      if (index == 0) {
        isLikeNumber = true;
      }
      return false;
    }
  }
}
