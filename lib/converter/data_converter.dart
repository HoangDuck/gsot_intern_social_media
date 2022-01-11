import 'dart:convert';
//import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/json_string/json_string.dart';
import 'package:social_media/model/messages.dart';
import 'package:social_media/model/notifiers.dart';
import 'package:social_media/model/posts.dart';
import 'package:social_media/model/user.dart';
final String listPostsFromJsonString=posts;
final String listMessagesFromJsonString=messages;
final String listUsersFromJsonString=users;
final String listNotifiersFromJsonString=notifiers;
class DataConvert{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<Message> listMessages=[];
  final List<Post> listPosts=[];
  final List<User> listUsers=[];
  int idCurrentUser=-1;
  User currentUser=User();
  final List<User> listUsersAfterLogin=[];
  final List<Notifier> listNotifiers=[];
  String stringDataUsers="";
  String stringDataMessages="";
  String stringDataNotifiers="";
  String stringDataPosts="";
  DataConvert();

  Future<bool> initData() async{
    await _getStringDataSharedPreferences();
    //chuyển Json qua list của Posts
    Iterable l = jsonDecode(stringDataPosts);
    List<Post> posts = List<Post>.from(l.map((model)=> Post.fromJson(model)));
    listPosts.clear();
    listPosts.addAll(posts);
    //chuyển Json qua list của users
    l = jsonDecode(stringDataUsers);
    List<User> users = List<User>.from(l.map((model)=> User.fromJson(model)));
    listUsers.clear();
    listUsers.addAll(users);
    //chuyển Json qua list của Messages
    l = jsonDecode(stringDataMessages);
    List<Message> messages = List<Message>.from(l.map((model)=> Message.fromJson(model)));
    listMessages.clear();
    listMessages.addAll(messages);
    //chuyển Json qua list của Notifiers
    l = jsonDecode(stringDataNotifiers);
    List<Notifier> notifiers = List<Notifier>.from(l.map((model)=> Notifier.fromJson(model)));
    listNotifiers.clear();
    listNotifiers.addAll(notifiers);
    return true;
  }
  Future<void> _getStringDataSharedPreferences() async {
    SharedPreferences prefs = await _prefs;
    idCurrentUser=prefs.getInt('id')??-1;
    stringDataUsers = prefs.getString('userAvatarData') ?? listUsersFromJsonString;
    prefs.setString('userAvatarData',stringDataUsers);
    stringDataMessages = prefs.getString('messagesData') ?? listMessagesFromJsonString;
    prefs.setString('messagesData',stringDataMessages);
    stringDataNotifiers = prefs.getString('notifiersData') ?? listNotifiersFromJsonString;
    prefs.setString('notifiersData',stringDataNotifiers);
    stringDataPosts=prefs.getString("postsData")?? listPostsFromJsonString;
    prefs.setString("postsData", stringDataPosts);
  }
  Future<User> insertDataUserAvatar(String name,String nickname) async {
    int id=listUsers.length+1;
    String picture="";
    String cover="";
    User user=User(id: id,name: name,nickname: nickname,picture: picture,cover: cover);
    String json='''
    {
      "id":$id,
      "name":"${user.name}",
      "nickname":"${user.nickname}",
      "picture": "${user.picture}",
      "cover": "${user.cover}"
    }''';
    SharedPreferences prefs = await _prefs;
    stringDataUsers = prefs.getString('userAvatarData') ?? listUsersFromJsonString;
    stringDataUsers=stringDataUsers.replaceAll("\n]", ",\n$json\n]");
    prefs.setString('userAvatarData',stringDataUsers);
    return user;
  }
  createListUsersAfterLogin(){
    listUsersAfterLogin.clear();
    if(idCurrentUser==-1){
      listUsersAfterLogin.addAll(listUsers);
      return;
    }
    else{
      List<User> list=[];
      list.addAll(listUsers);
      int index=-1;
      for(int i=0;i<list.length;i++){
        if(list[i].id==idCurrentUser){
          index=i;
          currentUser=list[i];
        }
      }
      list.removeAt(index);
      listUsersAfterLogin.addAll(list);
    }
  }
  Future<void> insertDataPost(String content,String image) async {
    int id=listPosts.length+1;
    //User user=User(id: id,name: name,nickname: nickname,picture: picture,cover: cover);
    String json='''
    {
      "id":$id,
      "user": 
      {
        "id":${currentUser.id},
        "name":"${currentUser.name}",
        "nickname": "${currentUser.nickname}",
        "picture": "${currentUser.picture}",
        "cover": "${currentUser.cover}"
      },
      "content": "$content",
      "image": "$image",
      "numberlikes": 0,
      "numbercomments": 0,
      "likes":
      [
      ],
      "comments":
      [
      ]
    }''';
    SharedPreferences prefs = await _prefs;
    stringDataPosts = prefs.getString('stringDataPosts') ?? listPostsFromJsonString;
    stringDataPosts=stringDataPosts.replaceAll("\n]", ",\n$json\n]");
    prefs.setString('stringDataPosts',stringDataPosts);
    Post post=Post(id: id,user: currentUser,content: content,image: image,likes: [],comments: []);
    listPosts.add(post);
  }
}
