import 'package:social_media/model/user.dart';

class Comment{
  int? id;
  User? user;
  String? content;
  String? image;
  Comment({this.id, this.user, this.content, this.image});

  factory Comment.fromJson(map){
    return Comment(
        id: map['id'],
        user: User.fromJson(map['user']),
        content: map['content'],
        image: map['image']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'user': user,
    'content': content,
    'image': image
  };
  static List<Comment> parseData(map){
    var list=map['comments'] as List;
    return list.map((comment) => Comment.fromJson(comment)).toList();
  }
}