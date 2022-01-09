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
  final List<Notifier> listNotifiers=[];
  String stringDataUsers="";
  String stringDataMessages="";
  String stringDataNotifiers="";

  DataConvert();

  Future<bool> initData() async{
    await _getStringDataSharedPreferences();
    //chuyển Json qua list của Posts
    Iterable l = jsonDecode(listPostsFromJsonString);
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
    stringDataUsers = prefs.getString('userAvatarData') ?? listUsersFromJsonString;
    prefs.setString('userAvatarData',stringDataUsers);
    stringDataMessages = prefs.getString('messagesData') ?? listMessagesFromJsonString;
    prefs.setString('messagesData',stringDataMessages);
    stringDataNotifiers = prefs.getString('notifiersData') ?? listNotifiersFromJsonString;
    prefs.setString('notifiersData',stringDataNotifiers);
  }
  insertDataUserAvatar(String name,String nickname) async {
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
    }
    ''';
    SharedPreferences prefs = await _prefs;
    stringDataUsers = prefs.getString('userAvatarData') ?? listUsersFromJsonString;
    stringDataUsers=stringDataUsers.substring(0,stringDataUsers.length-3);
    stringDataUsers="$stringDataUsers, \n$json]";
    prefs.setString('userAvatarData',stringDataUsers);
  }
}
