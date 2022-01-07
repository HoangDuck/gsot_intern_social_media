import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/view/chat.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/converter/login_data_converter.dart';
import 'package:social_media/view/notificationpage.dart';
import 'package:social_media/view/popupadd.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/view/profilepage.dart';
import 'view/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GSOT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(
          child: LoginPage(),
      )
    );
  }
}
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginDataConverter>.value(
        value: LoginDataConverter(),
        child: Material(child: LoginPageUI()),
    );
  }
}
class LoginPageUI extends StatefulWidget {
  const LoginPageUI({Key? key}) : super(key: key);

  @override
  _LoginPageUIState createState() => _LoginPageUIState();
}

class _LoginPageUIState extends State<LoginPageUI> {
  String _stateLogin="";
  late TextEditingController txtToDoControllerUsername;
  late TextEditingController txtToDoControllerPassword;
  void _stateLoginPasswordEmpty() {
    setState(() {
      _stateLogin="Username or password must not be empty";
    });
  }
  void _stateLoginPasswordWrongPassword() {
    setState(() {
      _stateLogin="Wrong password";
    });
  }
  void _stateLoginPasswordNotExist() {
    setState(() {
      _stateLogin="This account is not exist";
    });
  }

  @override
  void initState() {
    super.initState();
    txtToDoControllerUsername= TextEditingController();
    txtToDoControllerPassword= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    LoginDataConverter loginDataConvert=Provider.of<LoginDataConverter>(context);
    loginDataConvert.initData();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 100,bottom: 100,),
            child: Text("GSOT",
              style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: <Color>[
                      Color(0xff002fff),
                      Color(0xff00f4ff),
                    ],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
              ),
            ),
          ),
          TextFormField(
              controller: txtToDoControllerUsername,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder( //Outline border type for TextField
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              )
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: txtToDoControllerPassword,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder( //Outline border type for TextField
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            obscureText: true,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            child: Text(_stateLogin,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
          ),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.blue)
                    )
                )
            ),
            onPressed: () {
              if(txtToDoControllerUsername.text == ""
                  || txtToDoControllerPassword.text == ""){
                print(loginDataConvert.listUserLogins.length);
                _stateLoginPasswordEmpty();
                return;
              }
              try{
                for(int i=0;i<loginDataConvert.listUserLogins.length;i++){
                  var username=loginDataConvert.listUserLogins[i].username.toString();
                  var password=loginDataConvert.listUserLogins[i].password.toString();
                  if(username==txtToDoControllerUsername.text
                      && password==txtToDoControllerPassword.text){
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: SafeArea(
                                child: PageAfterLogin()
                            )
                        )
                    );
                    return;
                  }else if(username==txtToDoControllerUsername.text){
                    _stateLoginPasswordWrongPassword();
                    return;
                  }
                }
                _stateLoginPasswordNotExist();
              }catch(e){
                log(e.toString());
              }
            },
            child:
            Container(
              color: Colors.blue,
              child: const Center(
                child: Text("Login",style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.blue)
                    )
                )
            ),
            onPressed: () {

            },
            child:
            Container(
              color: Colors.blue,
              child: const Center(
                child: Text("Register",style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageAfterLogin extends StatelessWidget {
  const PageAfterLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<DataConvert>.value(
      value: DataConvert(),
      child: const Pages(),
    );
  }
}

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    dataConvert.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                icon: const Icon(Icons.home),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(0);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                icon: const Icon(Icons.chat),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(1);
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                icon: const Icon(Icons.my_library_add_rounded),
                onPressed: () {
                  setState(() {
                    PopupAdd(context);
                  });
                },
              ),
              IconButton(
                  iconSize: 30.0,
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(3);
                    });
                  }
              ),
              IconButton(
                iconSize: 30.0,
                icon: const Icon(Icons.account_circle_outlined),
                onPressed: () {
                  setState(() {
                    _myPage.jumpToPage(4);
                  });
                },
              )
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _myPage,
        children: <Widget>[
          HomePage(),
          Container(
              padding: const EdgeInsets.all(10),
              child: const ChatPage(),
          ),
          const Center(
            child: Text('Empty Body 2'),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const NotificationPage(),
          ),
          ProfilePage()
        ],
        physics: const NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
    );
  }
}


