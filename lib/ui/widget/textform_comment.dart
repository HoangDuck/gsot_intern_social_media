import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/ui/widget/post_widget.dart';

class TextFormComment extends StatefulWidget {
  const TextFormComment({Key? key}) : super(key: key);

  @override
  _TextFormCommentState createState() => _TextFormCommentState();
}

class _TextFormCommentState extends State<TextFormComment> {
  late TextEditingController textCommentEditingController;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFilePicker;

  set _imageFile(XFile? value) {
    _imageFilePicker = value;
  }


  @override
  Widget build(BuildContext context) {
    var t= Provider.of<PostWidgetState>(context);

    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: _previewImages(),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
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
                      setState(
                        () {
                          _onImageButtonPressed(
                            ImageSource.gallery,
                            context: context,
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.image),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        t.addComment();
                      });
                    },
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

  @override
  void initState() {
    super.initState();
    textCommentEditingController = TextEditingController();
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
