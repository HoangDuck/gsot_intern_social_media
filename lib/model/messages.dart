import 'User.dart';

class Message {
  int? id;
  User? user;
  String? content;
  String? time;
  int? numberNew;

  Message({this.id, this.user, this.content, this.time, this.numberNew});
  factory Message.fromJson(map){
    return Message(
        id: map['id'],
        user: User.fromJson(map['user']),
        content: map['content'],
        time: map['time'],
        numberNew:map['numbernew']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'user': user,
    'content': content,
    'time': time,
    'numbernew': numberNew
  };
}