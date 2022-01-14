import 'package:flutter/material.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/model/posts.dart';
class CommentPage extends StatefulWidget {
  final Post post;
  final DataConvert dataConvert;
  const CommentPage({Key? key,required this.post,required this.dataConvert}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late TextEditingController txtToDoControllerComment;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          children: [
            Expanded(child: _buildListComments()),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
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
                    icon: Icon(Icons.send),
                    onPressed: (){

                  },)
                ],
              ),
            ),
          ],
        ),
    );
  }
  Widget _buildListComments(){
    // DataConvert dataConvert=Provider.of<DataConvert>(context);
    // dataConvert.createListUsersAfterLogin();
    // return ListView.builder(
    //   itemCount: dataConvert.listUsersAfterLogin.length+1,
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context,i){
    //     if(i==0){
    //       return _addingWidget();
    //     }
    //     return _buildRow(dataConvert.listUsersAfterLogin[i-1]);
    //   },
    // );
    return ListView(
      children: [
        Container(
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
                  // backgroundImage:
                  // NetworkImage(data.user!.picture.toString()),
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
                        children: const [
                          Text("data.user!.name.toString()", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text("(data.content.toString()).susjadklajsdklajkdlkfjskdljfklskjdfskldfjklsdjklfjsdklfjklsdjfklsdjlfksdfjsdkljbstring(0,9)+", style: TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    txtToDoControllerComment=TextEditingController();
  }
}
