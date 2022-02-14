import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_media/ui/view/loginregister/login_register_page.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social media GSOT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: LoginPage(),
      ),
    );
  }
}