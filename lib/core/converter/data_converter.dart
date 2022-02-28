import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/json_string/json_string.dart';
import 'package:social_media/core/model/comment.dart';
import 'package:social_media/core/model/messages.dart';
import 'package:social_media/core/model/notifiers.dart';
import 'package:social_media/core/model/posts.dart';
import 'package:social_media/core/model/user.dart';
final String listPostsFromJsonString=posts;
final String listMessagesFromJsonString=messages;
final String listUsersFromJsonString=users;
final String listNotifiersFromJsonString=notifiers;
class DataConvert with ChangeNotifier{
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
    encodeJson(listUsers,listMessages,listNotifiers,listPosts);
    return true;
  }
  Future<void> encodeJson(List<User> listUsers,List<Message> listMessages,List<Notifier> listNotifiers,List<Post> listPosts,) async {
    SharedPreferences prefs = await _prefs;
    var jsonUsers=jsonEncode(listUsers);
    prefs.setString('userAvatarData',jsonUsers);
    var jsonMessages=jsonEncode(listMessages);
    prefs.setString('messagesData',jsonMessages);
    var jsonNotifiers=jsonEncode(listNotifiers);
    prefs.setString('notifiersData',jsonNotifiers);
    var jsonPosts=jsonEncode(listPosts);
    prefs.setString("postsData", jsonPosts);
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
    listUsers.add(user);
    var jsonUsers=jsonEncode(listUsers);
    SharedPreferences prefs = await _prefs;
    prefs.setString('userAvatarData',jsonUsers);
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
    Post post=Post(id: id,user: currentUser,content: content,image: image,numberLikes: 0,numberComments: 0,likes: [],comments: []);
    SharedPreferences prefs = await _prefs;
    // _write(stringDataPosts);
    listPosts.add(post);
    var jsonPosts=jsonEncode(listPosts);
    prefs.setString('postsData',jsonPosts);
    notifyListeners();
  }
  bool onLikeButtonPress(Post post,User user,List<Post> listPosts){
    bool value=false;
    if(isUserLikeThePost(post, user)){
      post.likes!.removeWhere((item) => item.id == user.id);
      if(post.numberLikes!=null){
        post.numberLikes=post.numberLikes!-1;
        value=false;
      }
    }else{
      post.likes!.add(user);
      if(post.numberLikes!=null){
        post.numberLikes=post.numberLikes!+1;
        value=true;
      }
    }
    var json=jsonEncode(listPosts);
    stringDataPosts=json;
    updateDataPost(stringDataPosts);
    return value;
  }
  bool isUserLikeThePost(Post post,User user){
    for(int i=0;i<post.likes!.length;i++){
      if(post.likes![i].id==user.id){
        return true;
      }
    }
    return false;
  }
  Future<void> updateDataPost(String stringData) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('postsData',stringData);
  }
  Future<void> insertDataComment(String content,String image,User? user,int idPost) async {
    int numberComments=0;
    int indexCurrentPost=0;
    for(int i=0;i<listPosts.length;i++){
      if(listPosts[i].id==idPost){
        numberComments=listPosts[i].comments!.length;
        indexCurrentPost=i;
      }
    }
    int id=numberComments+1;
    Comment comment=Comment(id: id,user: user,content: content,image: image);
    listPosts[indexCurrentPost].numberComments=listPosts[indexCurrentPost].numberComments!+1;
    listPosts[indexCurrentPost].comments!.add(comment);
    SharedPreferences prefs = await _prefs;
    // _write(stringDataPosts);
    var jsonPosts=jsonEncode(listPosts);
    prefs.setString('postsData',jsonPosts);
    notifyListeners();
  }
  Future<void> deleteDataComment(int idPost,int idComment) async{
    int indexPost=0;
    for(int i=0;i<listPosts.length;i++){
      if(listPosts[i].id==idPost){
        indexPost=i;
        break;
      }
    }
    listPosts[indexPost].numberComments=listPosts[indexPost].numberComments!-1;
    listPosts[indexPost].comments!.removeWhere((item) => item.id == idComment);
    var json=jsonEncode(listPosts);
    stringDataPosts=json;
    updateDataPost(stringDataPosts);
    notifyListeners();
  }
  int statisticPostNumber(){
    int nPost=0;
    for(int i=0;i<listPosts.length;i++){
      if(listPosts[i].user!.id==idCurrentUser){
        nPost++;
      }
    }
    return nPost;
  }
}
