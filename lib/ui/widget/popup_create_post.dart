import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:social_media/core/animation/expand_collapse_animation.dart';
import 'package:social_media/ui/constant/app_images.dart';

popUpCreatePost(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CreateNewPostWidget();
    },
  );
}

class CreateNewPostWidget extends StatefulWidget {
  const CreateNewPostWidget({Key? key}) : super(key: key);

  @override
  _CreateNewPostWidgetState createState() => _CreateNewPostWidgetState();
}

class _CreateNewPostWidgetState extends State<CreateNewPostWidget>
    with TickerProviderStateMixin {
  //show comment box
  late ExpandCollapseAnimation expandCollapseAnimation;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Stack(
        children: [
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Create New Post",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: Color(0xffff2B55),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xfff5f4f9),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEAEAEA),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEAEAEA),
                          ),
                        ),
                        hintText: 'Write something',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LineIcons.music,
                              color: Color(0xFF95949E),
                            ),
                          ),
                          backgroundColor: Color(0xFFF5F4F9),
                        ),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LineIcons.image,
                              color: Color(0xFF95949E),
                            ),
                          ),
                          backgroundColor: Color(0xFFF5F4F9),
                        ),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LineIcons.video,
                              color: Color(0xFF95949E),
                            ),
                          ),
                          backgroundColor: Color(0xFFF5F4F9),
                        ),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LineIcons.smilingFaceWithHeartEyes,
                              color: Color(0xFF95949E),
                            ),
                          ),
                          backgroundColor: Color(0xFFF5F4F9),
                        ),
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                expandCollapseAnimation.runExpand();
                              });
                            },
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Color(0xFFFF2B55),
                        ),
                      ],
                    ),
                  ),
                  SizeTransition(
                    axisAlignment: 1.0,
                    sizeFactor: expandCollapseAnimation.animation,
                    child: expandWidgetCreatingPost(),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xffff2b55),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Publish",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
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
    );
  }

  @override
  void initState() {
    super.initState();
    expandCollapseAnimation = ExpandCollapseAnimation(state: this);
  }

  Widget expandWidgetCreatingPost() {
    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xfff5f4f9),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: () {},
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage(recommend_image),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Ask for Recommendation",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                flex: 7,
              ),
            ],
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xfff5f4f9),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: () {},
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage(live_image),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Go Live",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                flex: 7,
              ),
            ],
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xfff5f4f9),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: () {},
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage(map_marker),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Check in",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                flex: 7,
              ),
            ],
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xfff5f4f9),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: () {},
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage(gif_image),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Gif",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                flex: 7,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (bool? value) {
                value = true;
              },
            ),
            Expanded(
              child: Icon(LineIcons.plusCircle),
              flex: 1,
            ),
            Expanded(
              child: Text("NewsFeed"),
              flex: 7,
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (bool? value) {
                value = true;
              },
            ),
            Expanded(
              child: Icon(LineIcons.user),
              flex: 1,
            ),
            Expanded(
              child: Text("Your stories"),
              flex: 7,
            ),
          ],
        ),
      ],
    );
  }
}
