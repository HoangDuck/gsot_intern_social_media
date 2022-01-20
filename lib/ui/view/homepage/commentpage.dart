import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/model/comment.dart';
import 'package:social_media/model/posts.dart';
//import 'package:social_media/view/uploadstatus.dart';
class CommentPage extends StatefulWidget {
  final int? idPost;
  const CommentPage({Key? key,this.idPost}) : super(key: key);

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

  var _tapPosition;
  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    Post post=findPost(widget.idPost!, dataConvert);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Material(
        child: Column(
          children: [
            Expanded(child: _buildListComments(post)),
            Container(
              alignment: Alignment.topLeft,
                child: _previewImages()
            ),
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
                    },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String pathImage,content;
                    content=txtToDoControllerComment.text;
                    try{
                      File file=File(_imageFilePicker!.path);
                      pathImage=await storeImageAndGetPath(file);
                    }catch(e){
                      pathImage="";
                    }
                    if(pathImage==""&&content==""){
                      return;
                    }else{
                      await dataConvert.insertDataComment(content,pathImage,dataConvert.currentUser,widget.idPost!);
                      XFile? file;
                      _imageFilePicker=file;
                      txtToDoControllerComment=TextEditingController();
                      setState(() {
                      });
                    }
                    },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Post findPost(int idPost,DataConvert dataConvert){
    for(int i=0;i<dataConvert.listPosts.length;i++){
      if(dataConvert.listPosts[i].id==idPost){
        return dataConvert.listPosts[i];
      }
    }
    return Post();
  }
  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
  Widget _buildListComments(Post post){
    return ListView.builder(
        itemCount: post.comments!.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,i){
          return _buildRow(context,post.comments![i],post.id);
        },
    );
  }
  Widget _buildRow(BuildContext context,Comment comment, int? idPost){
    DataConvert dataConvert=Provider.of<DataConvert>(context);
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
            child: GestureDetector(
              onLongPress: (){
                final RenderBox? overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                showMenu(
                    context: context,
                    position: RelativeRect.fromRect(
                        _tapPosition & const Size(40, 40), // smaller rect, the touch area
                        Offset.zero & overlay!.size   // Bigger rect, the entire screen
                    ),
                    items: [
                      PopupMenuItem(
                          onTap: (){
                            int? idComment=comment.id;
                            dataConvert.deleteDataComment(idPost!, idComment!);
                          },
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: (){
                                  Navigator.pop(context);
                                  int? idComment=comment.id;
                                  dataConvert.deleteDataComment(idPost!, idComment!);
                                },
                              ),
                              Text("Delete comment")
                            ],
                          )
                      )
                    ]);
              },
              onTapDown: _storePosition,
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
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comment.user!.name.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(comment.content.toString(), style: TextStyle(fontSize: 15),),
                        SizedBox(height: 5,),
                        Image.file(
                          File(comment.image.toString()),
                          errorBuilder: (context,error,stacktrace){
                            return Container();
                          },
                        )
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
        child: Container(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              SizedBox(
                height: 75,
                width: 55,
                child: kIsWeb
                    ? Image.network(_imageFilePicker.toString())
                    : Image.file(File(_imageFilePicker!.path)),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: (){
                    XFile? file;
                    _imageFilePicker=file;
                    setState((){
                    });
                  },
                  child: Icon(
                    Icons.delete_forever,
                  ),
                ),
              ),
            ]
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
