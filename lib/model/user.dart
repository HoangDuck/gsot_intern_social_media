class User{
  int? id;
  String? name;
  String? nickname;
  String? picture;
  User({this.id,this.name,this.nickname,this.picture});
  factory User.fromJson(map){
    return User(
      id: map['id'],
      name: map['name'],
      nickname: map['nickname'],
      picture: map['picture']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'name': name,
    'nickname': nickname,
    'picture': picture
  };
}