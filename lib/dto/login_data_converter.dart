import 'dart:convert';

import 'package:social_media/json_string/json_string_login.dart';
import 'package:social_media/model/user_login.dart';

final String loginData=login;
class LoginDataConverter{
  late final UserLogin loginDataConverter;
  LoginDataConverter();
  initData(){
    Map<String, dynamic> map=jsonDecode(loginData);
    var userLogin=UserLogin.fromJson(map);
    loginDataConverter=userLogin;
  }
}