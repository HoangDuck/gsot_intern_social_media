import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:social_media/ui/view/list_images_page.dart';
import 'package:social_media/ui/widget/comment_to_post_widget.dart';
import 'package:social_media/ui/widget/post_widget.dart';
import 'package:path/path.dart';

class TextFormComment extends StatefulWidget {
  const TextFormComment({Key? key}) : super(key: key);

  @override
  _TextFormCommentState createState() => _TextFormCommentState();
}

class _TextFormCommentState extends State<TextFormComment> {
  //edit text controller
  late TextEditingController textCommentEditingController;
  //state Object of post widget/list Image item widget
  late dynamic stateOfCurrentPost;
  //state Object of current comment to post/
  //header page of post in list image item/
  //list item image widget
  late dynamic stateOfCurrentComment;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFilePicker;

  set _imageFile(XFile? value) {
    _imageFilePicker = value;
  }

  @override
  void initState() {
    super.initState();
    textCommentEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    initStateVariable(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: _previewImages(),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: textCommentEditingController,
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
              hintText: 'Write comment',
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      _onImageButtonPressed(
                        ImageSource.gallery,
                        context: context,
                      );
                    },
                    icon: Icon(Icons.image),
                  ),
                  IconButton(
                    onPressed: _onTextFormButtonPressed,
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // this method to get state of Object from their parents stateful widget
  //receive state Object through Provider library
  void initStateVariable(BuildContext context){
    //stateOfCurrentPost variable can be state Object one of 3 widget below:
    //+ Post widget
    //+ header page widget in list image of post page
    //+ Image item in list image of post page
    //using try catch to assign them if two of them not exists
    //stateOfCurrentPost variable will be set to last stateObject
    try {
      stateOfCurrentPost = Provider.of<PostWidgetState>(context);
    } catch (e) {
      //print(e.toString());
    } finally {
      try {
        stateOfCurrentPost = Provider.of<PageHeaderState>(context);
      } catch (e) {
        //print(e.toString());
      } finally {
        try {
          stateOfCurrentPost = Provider.of<ItemListImageState>(context);
        } catch (e) {
          //print(e.toString());
        }
      }
    }
    //init state variable of comment to post to add comment reply
    try {
      stateOfCurrentComment = Provider.of<CommentToPostWidgetState>(context);
    } catch (e) {
      //print(e.toString());
    }
  }

  void _onTextFormButtonPressed() async {
    String pathImage, content;
    content = textCommentEditingController.text;
    try {
      File file = File(_imageFilePicker!.path);
      pathImage = await storeImageAndGetPath(file);
    } catch (e) {
      pathImage = "";
    }
    if (pathImage == "" && content == "") {
      return;
    } else {
      XFile? file;
      _imageFilePicker = file;
      textCommentEditingController = TextEditingController();
    }
    setState(() {
      try {
        stateOfCurrentComment.addReply({
          'name': 'Hoang Duc',
          'time': '2h',
          'content': content,
          'image': pathImage
        });
        stateOfCurrentPost.setState(() {
          stateOfCurrentPost.numberOfRepliesPost++;
          stateOfCurrentPost.numberOfComment++;
        });
        return;
      } catch (e) {
        //print(e);
      }
      stateOfCurrentPost.addComment({
        'name': 'Hoang Duc',
        'time': '2h',
        'content': content,
        'image': pathImage
      });
    });
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(
      () {
        _imageFile = pickedFile;
      },
    );
  }

  Future<String> storeImageAndGetPath(File file) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    String fileName = basename(file.path);
    final File newImage = await file.copy('${directory.path}/$fileName');
    return newImage.path.toString();
  }

  Widget _previewImages() {
    if (_imageFilePicker != null) {
      return Semantics(
        label: "image_picker_example_picked_image",
        child: Container(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              SizedBox(
                height: 75,
                width: 55,
                child: kIsWeb
                    ? Image.network(
                        _imageFilePicker.toString(),
                      )
                    : Image.file(
                        File(_imageFilePicker!.path),
                      ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    XFile? file;
                    _imageFilePicker = file;
                    setState(() {});
                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: Color(0xffFF2B55),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (_imageFilePicker == null) {
      return Container();
    } else {
      return Container();
    }
  }
}
