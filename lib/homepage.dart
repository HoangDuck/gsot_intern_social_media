import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/dto/data_converter.dart';
import 'package:social_media/model/posts.dart';
import 'package:social_media/model/user.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("GSOT",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xff002fff),
                          Color(0xff00f4ff),
                        ],
                      ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
                  ),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.0,
                            blurRadius: 20,
                          ),
                        ]
                    ),
                    child: IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.search),
                      onPressed: () {
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const ListAvatar(),
          const SizedBox(height: 10),
          const ListPosts(),
        ],
      ),
    );
  }
}
class ListAvatar extends StatefulWidget {
  const ListAvatar({Key? key}) : super(key: key);

  @override
  _ListAvatarState createState() => _ListAvatarState();
}

class _ListAvatarState extends State<ListAvatar> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 91.0,
      ),
      child: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions(){
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    return ListView.builder(
      itemCount: dataConvert.listUsers.length+1,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,i){
        if(i==0){
          return _AddingWidget();
        }
        return _buildRow(dataConvert.listUsers[i-1]);
      },
    );
  }
  Widget _AddingWidget(){
    return SizedBox(
        width: 70.0,
        height: 60.0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Colors.grey,
                    width: 2
                ),
              ),
              child: SizedBox(
                width: 55,
                height: 55,
                child: Ink(
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  child:IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      },
                  ),
                ),
              ),
            ),
            const Text("You",style: TextStyle(fontSize: 14),)
          ],
        ),
    );
  }
  Widget _buildRow(User data) {
    return SizedBox(
        width: 70.0,
        height: 60.0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Colors.blue,
                    width: 2
                ),
              ),
              child: SizedBox(
                width: 55,
                height: 55,
                child: Ink(
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  child:IconButton(
                    color: Colors.grey,
                    icon: Image.network(data.picture.toString()),
                    onPressed: () {
                      },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 50,
                child: Text(
                  data.name.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
            )
          ],
        ),
    );
  }
}

class ListPosts extends StatefulWidget {
  const ListPosts({Key? key}) : super(key: key);

  @override
  _ListPostsState createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: dataConvert.listPosts.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,i){
          return _buildRow(dataConvert.listPosts[i]);
        },
      ),
    );
  }
  Widget _buildRow(Post data) {
    return Container(
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
              SizedBox(
                height: 65.0,
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    SizedBox(
                        height: 55,
                        width: 55,
                        child: Image.network(data.user!.picture.toString())
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.user!.name.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text(data.user!.nickname.toString(), style: const TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.more_vert),
                      ),
                    ),
                    const SizedBox(width: 10,)
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(data.content.toString(),style: const TextStyle(fontSize: 20, color: Colors.black54),),
              ),
              Container(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  ),
                ),
                child: SizedBox(
                  height: 50.0,
                  child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.chat_bubble_outlined),
                      Text(data.numberComments.toString(),style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(width: 15,),
                      const Icon(Icons.favorite),
                      Text(data.numberLikes.toString(),style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.bookmark),
                        ),
                      ),
                      const SizedBox(width: 10,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}