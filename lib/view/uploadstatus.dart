import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/model/user.dart';
class UploadStatus extends StatefulWidget {
  const UploadStatus({Key? key}) : super(key: key);
  @override
  _UploadStatusState createState() => _UploadStatusState();
}

class _UploadStatusState extends State<UploadStatus> {
  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    User user=dataConvert.currentUser;
    return Material(
      child: Container(
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
                        child: const Icon(Icons.cancel),
                      ),
                    ),
                    const SizedBox(width: 10,)
                  ],
                ),
              ),
              Expanded(child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Text("data.content.toString()",style: const TextStyle(fontSize: 20, color: Colors.black54),),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: Center(
                  child: Image.network(
                    //data.image.toString(),
                    "https://cdn.baogiaothong.vn/upload/images/2020-4/article_social_image/2020-12-15/noel-1608021530-width1200height630-auto-crop-1608021622-width1200height630-1608021625-width1200height630.jpg",
                    errorBuilder: (context,error,stacktrace){
                      return Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
