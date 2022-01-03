import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/model/user.dart';

import 'dto/data_converter.dart';
import 'model/messages.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Chats",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
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
          const SizedBox(height: 10),
          const TextField(
              //controller: username,
              decoration: InputDecoration(
                labelText: "Search chat here..",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder( //Outline border type for TextField
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              )
          ),
          const SizedBox(height: 10),
          const QuickChat(),
          const Expanded(child: Messages()),
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
        Text("Messages",
          style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        SizedBox(height: 10),
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
        itemCount: dataConvert.listMessages.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,i) => _buildRow(dataConvert.listMessages[i]),
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
                        child: Image.network(data.user!.picture.toString())
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
        Text("Quick Chat",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
          ),
        ),
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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 91.0,
      ),
      child: ListView.builder(
        itemCount: dataConvert.listUsers.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,i) => _buildRow(dataConvert.listUsers[i]),
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
