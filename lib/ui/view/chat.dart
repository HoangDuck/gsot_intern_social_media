import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/core/model/user.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/shapedecorationbuttonsearch.dart';
import 'package:social_media/ui/constant/text_styles.dart';

import '../../core/converter/data_converter.dart';
import '../../core/model/messages.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Chats", style: textSize35Bold),
              SizedBox(
                width: 35,
                height: 35,
                child: Ink(
                  decoration:shapeDecorationShadow(10),
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
          Expanded(child: Messages()),
        ],
      ),
    );
  }
}
class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ListMessages(),
      ],
    );
  }
}
class ListMessages extends StatefulWidget {
  const ListMessages({Key? key}) : super(key: key);

  @override
  _ListMessagesState createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: dataConvert.listMessages.length+1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,i){
          if(i==0){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 10),
                TextField(
                  //controller: username,
                    decoration: InputDecoration(
                      labelText: "Search chat here..",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    )
                ),
                SizedBox(height: 10),
                QuickChat(),
                Text("Messages", style: textSize20BoldBack87),
                SizedBox(height: 10),
              ],
            );
          }
          int index=i-1;
          return _buildRow(dataConvert.listMessages[index]);
        },
      ),
    );
  }
  Widget _buildRow(Message data){
    return Container(
        padding: const EdgeInsets.all(5),
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
          child: Column(
            children: [
              SizedBox(
                height: 65.0,
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                          NetworkImage(data.user!.picture.toString()),
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
                          Text(data.user!.name.toString(), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 5,),
                          Text((data.content.toString()).substring(0,9)+"...", style: const TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(data.time.toString(), style: const TextStyle(fontSize: 13, color: Colors.grey),),
                            _numberOfNewMessages(data),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
  Widget _numberOfNewMessages(Message data){
    if(data.numberNew.toString() == "0"){
      return Container();
    }
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Colors.purple, // border color
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2), // border width
        child: Container( // or ClipRRect if you need to clip the content
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.purple, // inner circle color
          ),
          child: Center(
            child: Text(
              data.numberNew.toString(),
              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ), // inner content
        ),
      ),
    );
  }
}

class QuickChat extends StatefulWidget {
  const QuickChat({Key? key}) : super(key: key);

  @override
  _QuickChatState createState() => _QuickChatState();
}

class _QuickChatState extends State<QuickChat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Quick Chat", style: textSize20BoldBack87),
        SizedBox(height: 10),
        ListAvatarOnline(),
      ],
    );
  }
}
class ListAvatarOnline extends StatefulWidget {
  const ListAvatarOnline({Key? key}) : super(key: key);

  @override
  _ListAvatarOnlineState createState() => _ListAvatarOnlineState();
}

class _ListAvatarOnlineState extends State<ListAvatarOnline> {
  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    dataConvert.createListUsersAfterLogin();
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 84.0,
      ),
      child: ListView.builder(
        itemCount: dataConvert.listUsersAfterLogin.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,i) => _buildRow(dataConvert.listUsersAfterLogin[i]),
      ),
    );
  }
  Widget _buildRow(User data) {
    return SizedBox(
        width: 60.0,
        height: 60.0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: colorPopupWidget,
                image: DecorationImage(
                  image: NetworkImage(data.picture.toString()),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all( Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: IconButton(
                icon: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  },
              ),
            ),
            SizedBox(
              width: 50,
              child: Text(
                data.name.toString(),
                textAlign: TextAlign.center,
                style: textSize14,
              ),
            )
          ],
        ),
    );
  }
}
