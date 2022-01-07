import 'package:social_media/model/user.dart';

class UserLogin{
  int? id;
  User? user;
  String? username;
  String? password;
  UserLogin({this.id,this.user,this.username,this.password});
  factory UserLogin.fromJson(map){
    return UserLogin(
        id: map['id'],
        user: User.fromJson(map['user']),
        username: map['username'],
        password: map['password']
    );
  }
  Map<String,dynamic> toJson() => {
    'id':id,
    'user': user,
    'username': username,
    'password': password
  };
}