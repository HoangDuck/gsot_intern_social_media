import 'package:social_media/model/user.dart';

class UserProfile{
  int? id;
  User? user;
  int? posts;
  int? following;
  int? follower;
  List<dynamic>? listImage;
  UserProfile({this.id,this.user,this.posts,this.follower,this.following,this.listImage});
  factory UserProfile.fromJson(map){
    return UserProfile(
        id: map['id'],
        user: User.fromJson(map['user']),
        posts: map['posts'],
        follower: map['followers'],
        following: map['following'],
        listImage: map['album']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'user': user,
    'posts': posts,
    'followers':follower,
    'following':following,
    'album':listImage
  };
}