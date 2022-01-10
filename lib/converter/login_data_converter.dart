import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/json_string/json_string_login.dart';
import 'package:social_media/model/user.dart';
import 'package:social_media/model/user_login.dart';

String loginData=login;
class LoginDataConverter{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<UserLogin> listUserLogins=[];
  String stringData="";
  LoginDataConverter();
  initData()async{
    await _getStringDataSharedPreferences();
    //chuyển Json qua list của Posts
    Iterable l = jsonDecode(stringData);
    List<UserLogin> userLogins = List<UserLogin>.from(l.map((model)=> UserLogin.fromJson(model)));
    listUserLogins.clear();
    listUserLogins.addAll(userLogins);
  }
  Future<void> _getStringDataSharedPreferences() async {
    SharedPreferences prefs = await _prefs;
    stringData = prefs.getString('loginData') ?? loginData;
    prefs.setString('loginData',stringData);
  }
  insertData(User user,String username, String password)async{
    int id=listUserLogins.length+1;
    UserLogin userLogin=UserLogin(id: id,user: user,username: username,password: password);
    String json='''
  {
    "id":$id,
    "user":
    {
      "id":${user.id},
      "name":"${user.name}",
      "nickname":"${user.nickname}",
      "picture": "${user.picture}",
      "cover": "${user.cover}"
    },
    "username": "${userLogin.username}",
    "password": "${userLogin.password}"
  }''';
    SharedPreferences prefs = await _prefs;
    stringData = prefs.getString('loginData') ?? loginData;
    stringData=stringData.replaceAll("\n]", ",\n$json\n]");
    prefs.setString('loginData',stringData);
  }
}