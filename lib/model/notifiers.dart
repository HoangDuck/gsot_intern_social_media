import 'package:social_media/model/user.dart';

class Notifier{
  int? id;
  User? user;
  String? content;
  String? time;
  String? read;

  Notifier({this.id, this.user, this.content, this.time, this.read});

  factory Notifier.fromJson(map){
    return Notifier(
        id: map['id'],
        user: User.fromJson(map['user']),
        content: map['content'],
        time: map['time'],
        read: map['read']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'user': user,
    'content': content,
    'time': time,
    'read': read
  };
}