import 'dart:convert';
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
  final List<Message> listMessages=[];
  final List<Post> listPosts=[];
  final List<User> listUsers=[];
  final List<Notifier> listNotifiers=[];
  DataConvert();

  initData(){
    //chuyển Json qua list của Posts
    Iterable l = jsonDecode(listPostsFromJsonString);
    List<Post> posts = List<Post>.from(l.map((model)=> Post.fromJson(model)));
    listPosts.addAll(posts);
    //chuyển Json qua list của users
    l = jsonDecode(listUsersFromJsonString);
    List<User> users = List<User>.from(l.map((model)=> User.fromJson(model)));
    listUsers.addAll(users);
    //chuyển Json qua list của Messages
    l = jsonDecode(listMessagesFromJsonString);
    List<Message> messages = List<Message>.from(l.map((model)=> Message.fromJson(model)));
    listMessages.addAll(messages);
    //chuyển Json qua list của Notifiers
    l = jsonDecode(listNotifiersFromJsonString);
    List<Notifier> notifiers = List<Notifier>.from(l.map((model)=> Notifier.fromJson(model)));
    listNotifiers.addAll(notifiers);
  }
}
