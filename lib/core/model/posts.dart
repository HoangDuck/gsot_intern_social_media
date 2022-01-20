import 'package:social_media/core/model/comment.dart';
import 'package:social_media/core/model/user.dart';

class Post{
  int? id;
  User? user;
  String? content;
  String? image;
  int? numberLikes;
  int? numberComments;
  List<User>? likes;
  List<Comment>? comments;
  Post({this.id, this.user, this.content, this.image, this.numberLikes,
      this.numberComments,this.likes,this.comments});

  factory Post.fromJson(map){
    return Post(
        id: map['id'],
        user: User.fromJson(map['user']),
        content: map['content'],
        image: map['image'],
      numberLikes:map['numberlikes'],
      numberComments: map['numbercomments'],
      likes: User.parseData(map),
      comments: Comment.parseData(map)
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'user': user,
    'content': content,
    'image': image,
    'numberlikes': numberLikes,
    'numbercomments': numberComments,
    'likes': likes,
    'comments': comments
  };
}