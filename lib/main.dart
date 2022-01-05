import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/view/chat.dart';
import 'package:social_media/dto/data_converter.dart';
import 'package:social_media/dto/login_data_converter.dart';
import 'package:social_media/model/user_login.dart';
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
        child: const Material(child: LoginPageUI()),
    );
  }
}
class LoginPageUI extends StatelessWidget {
  const LoginPageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txtToDoControllerUsername= TextEditingController();
    var txtToDoControllerPassword= TextEditingController();
    LoginDataConverter loginDataConvert=Provider.of<LoginDataConverter>(context);
    loginDataConvert.initData();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(100),
            child: Text("GSOT",
              style: TextStyle(
                  fontSize: 45,
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
          SizedBox(height: 30),
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
              try{
                UserLogin userLogin=UserLogin();
                userLogin=loginDataConvert.loginDataConverter;
                var username=userLogin.username.toString();
                var password=userLogin.password.toString();
                if(username==txtToDoControllerUsername.text
                    && password==txtToDoControllerPassword.text){
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SafeArea(child: PageAfterLogin())));
                }
              }catch(e){
                print(e.toString());
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


