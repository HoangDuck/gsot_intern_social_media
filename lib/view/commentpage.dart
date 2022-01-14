import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/model/comment.dart';
import 'package:social_media/model/posts.dart';
class CommentPage extends StatefulWidget {
  final Post post;
  final DataConvert dataConvert;
  const CommentPage({Key? key,required this.post,required this.dataConvert}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFilePicker;
  late TextEditingController txtToDoControllerComment;
  set _imageFile(XFile? value) {
    _imageFilePicker = value;
  }
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          children: [
            Expanded(child: _buildListComments()),
            Row(
              children: [
                Expanded(
                  child:
                    TextField(
                      controller: txtToDoControllerComment,
                      decoration: InputDecoration(
                      labelText: "Comment...",
                      border: OutlineInputBorder( //Outline border type for TextField
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: (){
                    _onImageButtonPressed(ImageSource.gallery, context: context);
                  },),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (){

                },)
              ],
            ),
          ],
        ),
    );
  }
  Widget _buildListComments(){
    return ListView.builder(
      itemCount: widget.post.comments!.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,i){
        return _buildRow(widget.post.comments![i]);
      },
    );
  }
  Widget _buildRow(Comment comment){
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage:
              NetworkImage(comment.user!.picture.toString()),
              backgroundColor: Colors.black,
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Container(
              decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: -9,
                      blurRadius: 15,
                    ),
                  ]
              ),
              child: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.user!.name.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text(comment.content.toString(), style: TextStyle(fontSize: 15),)
                    ],
                  ),
                ),
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
    txtToDoControllerComment=TextEditingController();
  }
  void _onImageButtonPressed(ImageSource source, {BuildContext? context}) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    },
    );
  }
  Future<String> storeImageAndGetPath(File file) async{
    final Directory directory = await getApplicationDocumentsDirectory();
    String fileName=basename(file.path);
    final File newImage = await file.copy('${directory.path}/$fileName');
    return newImage.path.toString();
  }
  Widget _previewImages() {
    if (_imageFilePicker != null) {
      return Semantics(
        label: "image_picker_example_picked_image",
        child: kIsWeb
            ? Image.network(_imageFilePicker.toString())
            : Image.file(File(_imageFilePicker!.path)),
      );
    } else if (_imageFilePicker == null) {
      return Container();
    } else {
      return Container();
    }
  }
}
