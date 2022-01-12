import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/model/user.dart';
import 'package:image_picker/image_picker.dart';
class UploadStatus extends StatefulWidget {
  const UploadStatus({Key? key}) : super(key: key);
  @override
  _UploadStatusState createState() => _UploadStatusState();
}

class _UploadStatusState extends State<UploadStatus> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFilePicker;

  set _imageFile(XFile? value) {
    _imageFilePicker = value;
  }
  // Pick an image
  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    User user=dataConvert.currentUser;
    return Material(
      child: Container(
        color: Colors.blueAccent,
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 0.0,
                  blurRadius: 20,
                ),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: SizedBox(
                  height: 65.0,
                  child: Row(
                    children: [
                      const SizedBox(width: 10,),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                          NetworkImage(user.picture.toString()),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(user.nickname.toString(), style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,)
                    ],
                  ),
                ),
              ),
              TextFormField(
                initialValue: 'What do you think?',
                cursorColor: Colors.black,
                maxLines: 5,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Tell your thinking here"),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: _previewImages(),
                  ),
                ),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: (){
                        _onImageButtonPressed(ImageSource.gallery, context: context);
                      },
                      icon: Icon(Icons.image),
                  ),
                  IconButton(
                    onPressed: (){
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _onImageButtonPressed(ImageSource source, {BuildContext? context}) async {
    final pickedFile = await _picker.pickImage(source: source,);
    setState(() {
      _imageFile = pickedFile;
      },
    );
  }
  Widget _previewImages() {
    if (_imageFilePicker != null) {
      return Semantics(
                label: "image_picker_example_picked_image",
                child: kIsWeb
                    ? Image.network(_imageFilePicker.toString())
                    : Image.file(File(_imageFilePicker!.path)),
              );
    } else if (_imageFilePicker != null) {
      return Text(
        'Pick image error: $_imageFilePicker',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }
  @override
  void initState() {
    super.initState();

  }
}
