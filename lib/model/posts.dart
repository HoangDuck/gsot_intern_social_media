import 'package:social_media/model/User.dart';

class Post{
  int? id;
  User? user;
  String? content;
  String? image;
  int? numberLikes;
  int? numberComments;

  Post({this.id, this.user, this.content, this.image, this.numberLikes,
      this.numberComments});

  factory Post.fromJson(map){
    return Post(
        id: map['id'],
        user: User.fromJson(map['user']),
        content: map['content'],
        image: map['image'],
      numberLikes:map['numberlikes'],
      numberComments: map['numbercomments']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'user': user,
    'content': content,
    'image': image,
    'numberlikes': numberLikes,
    'numbercomments': numberComments
  };
}