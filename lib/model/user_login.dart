class UserLogin{
  int? id;
  String? name;
  String? nickname;
  String? picture;
  String? username;
  String? password;
  UserLogin({this.id,this.name,this.nickname,this.picture,this.username,this.password});
  factory UserLogin.fromJson(map){
    return UserLogin(
        id: map['id'],
        name: map['name'],
        nickname: map['nickname'],
        picture: map['picture'],
        username: map['username'],
        password: map['password']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'name': name,
    'nickname': nickname,
    'picture': picture,
    'username': username,
    'password': password
  };
}