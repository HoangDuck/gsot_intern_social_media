import 'package:flutter/material.dart';
import 'package:social_media/core/util/utils.dart';

class ReactionStatisticWidget extends StatelessWidget {
  List<String> listOfReactionsIcon = [
    'Angry',
    'Love',
  ];

  //this field false is number of reaction hasn't appeared yet
  //this field true is number of reaction has appeared
  bool isLikeNumber = false;
  int numberReaction=103;
  ReactionStatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //these positioned widget check the list at
        // index has an item, if it doesn't have any item they will have
        // container widget
        Positioned(
          child: _widgetReturnIcon(0),
        ),
        Positioned(
          left: 20,
          child: _widgetReturnIcon(1),
        ),
        Positioned(
          left: 40,
          child: _widgetReturnIcon(2),
        ),
        Positioned(
          left: 60,
          child: _widgetReturnIcon(3),
        ),
        Positioned(
          left: 80,
          child: _widgetReturnIcon(4),
        ),
        Positioned(
          left: 100,
          child: _widgetReturnIcon(5),
        ),
      ],
    );
  }

  Widget _widgetReturnIcon(int index) {
    if(checkDataIconList(index)){
      return Image(
        width: 24,
        image: AssetImage(
          Utils.getPathIconReaction(
            listOfReactionsIcon[index],
          ),
        ),
      );
    }
    if(!isLikeNumber){
      isLikeNumber=true;
      return Container(
        padding: EdgeInsets.only(
          left: 5,
          top: 2,
        ),
        child: Text(
          numberReaction.toString(),
          style: TextStyle(fontSize: 17),
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
      listOfReactionsIcon[index];
      return true;
    } catch (e) {
      return false;
    }
  }
}
