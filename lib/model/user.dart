class User{
  int? id;
  String? name;
  String? nickname;
  String? picture;
  String? cover;
  User({this.id,this.name,this.nickname,this.picture,this.cover});
  factory User.fromJson(map){
    return User(
      id: map['id'],
      name: map['name'],
      nickname: map['nickname'],
      picture: map['picture'],
      cover: map['cover']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'name': name,
    'nickname': nickname,
    'picture': picture,
    'cover': cover
  };
}