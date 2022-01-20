import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget stateLoginRegisterName(BuildContext context,String state){
  return Container(
    //container để hiện statelogin nếu người dùng đăng nhập có vấn đề như sai mk hoặc username
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(2.5),
    child: Text(state,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
  );
}
Widget containerPadding10(BuildContext context){
  return Container(
    //container để hiện statelogin nếu người dùng đăng nhập có vấn đề như sai mk hoặc username
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(10),
  );
}