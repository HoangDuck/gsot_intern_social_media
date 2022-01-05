class UserProfile{
  int? id;
  String? name;
  String? nickname;
  String? picture;
  String? cover;
  int? posts;
  int? following;
  int? follower;
  List<dynamic>? listImage;
  UserProfile({this.id,this.name,this.nickname,this.picture,this.cover,this.posts,this.follower,this.following,this.listImage});
  factory UserProfile.fromJson(map){
    return UserProfile(
        id: map['id'],
        name: map['name'],
        nickname: map['nickname'],
        picture: map['picture'],
        cover: map['cover'],
        posts: map['posts'],
        follower: map['followers'],
        following: map['following'],
        listImage: map['album']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'name': name,
    'nickname': nickname,
    'picture': picture,
    'cover': cover,
    'posts': posts,
    'followers':follower,
    'following':following,
    'album':listImage
  };
}