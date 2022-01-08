import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/view/chat.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/converter/login_data_converter.dart';
import 'package:social_media/view/notificationpage.dart';
import 'package:social_media/view/popupadd.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/view/profilepage.dart';
import 'package:social_media/view/registerpage.dart';
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
  //tạo 1 provider để lấy thông tin đăng nhập để sẵn
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
  // login page là stateful vì còn thực hiện check lỗi login để báo lỗi đến người dùng
  @override
  _LoginPageUIState createState() => _LoginPageUIState();
}

class _LoginPageUIState extends State<LoginPageUI> {
  String _stateLogin="";// để chứa thông tin về các trạng thái đăng nhập đúng sai
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
    //vừa hiện widget là khởi tạo controller để người dùng nhập vào
    txtToDoControllerUsername= TextEditingController();
    txtToDoControllerPassword= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    LoginDataConverter loginDataConvert=Provider.of<LoginDataConverter>(context);
    loginDataConvert.initData();// lấy dữ liệu đăng nhập từ local storage
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
            //container để hiện statelogin nếu người dùng đăng nhập có vấn đề như sai mk hoặc username
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
              //check điều kiện người dùng bỏ trống 1 trong 2 username và password
              if(txtToDoControllerUsername.text == ""
                  || txtToDoControllerPassword.text == ""){
                _stateLoginPasswordEmpty();//gọi hàm setstate trong hàm này và xuất ra message
                return;
              }
              try{
                //vì thiết bị có thể có nhìu hơn 1 tk đăng nhập nên chỗ này phải có for
                for(int i=0;i<loginDataConvert.listUserLogins.length;i++){
                  var idUser=loginDataConvert.listUserLogins[i].user!.id;
                  var username=loginDataConvert.listUserLogins[i].username.toString();
                  var password=loginDataConvert.listUserLogins[i].password.toString();
                  if(username==txtToDoControllerUsername.text
                      && password==txtToDoControllerPassword.text){
                    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                    _prefs.then((value) async{
                      return await value.setInt('id', idUser!);
                    });
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
                    //check ràng buộc người dùng sai mk
                  }else if(username==txtToDoControllerUsername.text){
                    _stateLoginPasswordWrongPassword();
                    return;
                  }
                }
                //không rời vào các trường hợp trên thì báo tk ko tồn tại
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
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: SafeArea(
                          child: RegisterProviderUI()
                      )
                  )
              );
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
      child: Pages(),
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
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: Provider.of<DataConvert>(context).initData(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return buildHomePage(context);
          }
          return Container();
        },
    );
  }
  //UI Homepage
  Widget buildHomePage(BuildContext context){
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
            child: ChatPage(),
          ),
          const Center(
            child: Text('Empty Body 2'),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: NotificationPage(),
          ),
          ProfilePage()
        ],
        physics: const NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
      ),
    );
  }
}


