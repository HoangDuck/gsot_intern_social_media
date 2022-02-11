import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/core/converter/login_data_converter.dart';
import 'package:social_media/ui/constant/button_styles.dart';
import 'package:social_media/ui/constant/text_styles.dart';
import 'package:social_media/ui/view/pageafterlogin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media/ui/view/register/registerpage.dart';
import 'package:social_media/ui/widget/stateloginregistername.dart';
import 'package:social_media/ui/widget/textformfieldlogin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GSOT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _getIdUser(),
      builder: (context, snapshot) {
        // khi có lỗi thì sẽ treo chữ GSOT
        if (snapshot.hasError) {
          return Material(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text("GSOT", style: titleAppGsotLoginPage),
              ),
            ),
          );
        }
        //khi có dữ liệu là check trong pref có data user (bằng getIdUser) nếu -1
        // thì trang login ngược lại thì vô page của user
        if (snapshot.hasData) {
          if (snapshot.data != -1) {
            return PageAfterLogin();
          }
          return Provider<LoginDataConverter>.value(
            value: LoginDataConverter(),
            child: Material(child: FormUI()),
          );
        }
        // mặc định là trạng thái không kết nối thì sẽ treo chữ GSOT
        return Material(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Text("GSOT", style: titleAppGsotLoginPage),
            ),
          ),
        );
      },
    );
  }

  Future<int> _getIdUser() async {
    // hàm để check ID user có lưu trong pref không
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = -1;
    id = prefs.getInt('id') ?? -1;
    return id;
  }
}

class FormUI extends StatefulWidget {
  const FormUI({Key? key}) : super(key: key);

  @override
  _FormUIState createState() => _FormUIState();
}

class _FormUIState extends State<FormUI> {
  bool signInPress = true;
  bool signUpPress = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            color: Colors.white,
            child: Stack(
              children: [
                Image(
                  image: AssetImage('assets/images/login-bg2.jpg'),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Image(image: AssetImage('assets/images/logo.png')),
                      FormField(
                          signInPress: signInPress, signUpPress: signUpPress),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.1,
                bottom: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Or",
                      style: TextStyle(
                          fontSize: 38,
                          color: Color(0xff6d6a6d),
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "Login with",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff4b4a4a),
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xff1245bd),
                          child: IconButton(
                              color: Colors.white,
                              icon: Icon(LineIcons.facebookF),
                              onPressed: () {}),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.red,
                          child: IconButton(
                              color: Colors.white,
                              icon: Icon(LineIcons.googleLogo),
                              onPressed: () {}),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              color: Colors.white,
                              icon: Icon(LineIcons.twitter),
                              onPressed: () {}),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      Positioned(
        bottom: MediaQuery.of(context).size.width * 0.6,
        right: MediaQuery.of(context).size.width / 2 + 10,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              signInPress = true;
              signUpPress = false;
            });
          },
          label: Text(
            'Sign in',
            style: TextStyle(
              color: signInPress ? Colors.white : Colors.black87,
            ),
          ),
          icon: Icon(
            LineIcons.key,
            color: signInPress ? Colors.white : Colors.black87,
          ),
          backgroundColor: signInPress ? Color(0xffff008c) : Color(0xffe3e3e3),
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(context).size.width * 0.6, //modify top
        left: MediaQuery.of(context).size.width / 2 + 10,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              signInPress = false;
              signUpPress = true;
            });
          },
          label: Text(
            'Signup',
            style: TextStyle(
              color: signUpPress ? Colors.white : Colors.black87,
            ),
          ),
          icon: Icon(
            LineIcons.alternatePencil,
            color: signUpPress ? Colors.white : Colors.black87,
          ),
          backgroundColor: signUpPress ? Color(0xffff008c) : Color(0xffe3e3e3),
        ),
      ),
    ]);
  }
}

class FormField extends StatefulWidget {
  final bool signUpPress;
  final bool signInPress;

  const FormField(
      {Key? key, required this.signInPress, required this.signUpPress})
      : super(key: key);

  @override
  State<FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormField> {
  String _stateLogin =
      ""; // để chứa thông tin về các trạng thái đăng nhập đúng sai
  late TextEditingController txtToDoControllerUsername;
  late TextEditingController txtToDoControllerPassword;
  late TextEditingController txtToDoControllerRetypePass;

  @override
  Widget build(BuildContext context) {
    LoginDataConverter loginDataConvert =
        Provider.of<LoginDataConverter>(context);
    loginDataConvert.initData(); // lấy dữ liệu đăng nhập từ local storage
    if (widget.signUpPress) {
      return signUpForm(context);
    }
    return signInForm(context);
  }

  @override
  void initState() {
    super.initState();
    txtToDoControllerUsername = TextEditingController();
    txtToDoControllerPassword = TextEditingController();
    txtToDoControllerRetypePass = TextEditingController();
  }

  Widget signUpForm(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Proceed With Your Registration",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: const [
                  Icon(
                    LineIcons.key,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Signup",
                    style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  LineIcons.user,
                  color: Colors.white54,
                ),
                hintText: "Username",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: txtToDoControllerPassword,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  LineIcons.lock,
                  color: Colors.white54,
                ),
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
              obscureText: true,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  LineIcons.lock,
                  color: Colors.white54,
                ),
                hintText: "Retype Password",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
              obscureText: true,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: ElevatedButton(
                style: buttonStyleLogin,
                onPressed: () {
                  //onPressButtonRegister();
                },
                child: Text(
                  "Signup",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.015,
            ),
            alignment: Alignment.center,
            child: Text(
              "Already Have An Account?",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget signInForm(BuildContext context) {
    LoginDataConverter loginDataConverter =
        Provider.of<LoginDataConverter>(context);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Proceed With Your Login",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: const [
                  Icon(
                    LineIcons.key,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: txtToDoControllerUsername,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  LineIcons.user,
                  color: Colors.white54,
                ),
                hintText: "Username",
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              controller: txtToDoControllerPassword,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  LineIcons.lock,
                  color: Colors.white54,
                ),
                hintText: "Password",
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                    color: Colors.white,
                  ),
                ),
              ),
              obscureText: true,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: ElevatedButton(
                style: buttonStyleLogin,
                onPressed: () {
                  //check điều kiện người dùng bỏ trống 1 trong 2 username và password
                  if (txtToDoControllerUsername.text == "" ||
                      txtToDoControllerPassword.text == "") {
                    //_stateLoginPasswordEmpty();//gọi hàm setstate trong hàm này và xuất ra message
                    return;
                  }
                  try {
                    //vì thiết bị có thể có nhìu hơn 1 tk đăng nhập nên chỗ này phải có for
                    for (int i = 0;
                        i < loginDataConverter.listUserLogins.length;
                        i++) {
                      var idUser =
                          loginDataConverter.listUserLogins[i].user!.id;
                      var username = loginDataConverter
                          .listUserLogins[i].username
                          .toString();
                      var password = loginDataConverter
                          .listUserLogins[i].password
                          .toString();
                      if (username == txtToDoControllerUsername.text &&
                          password == txtToDoControllerPassword.text) {
                        //save session
                        loginDataConverter.setIdUser(idUser!);
                        //dang nhap thanh cong thi xoa canh bao
                        setState(() {
                          txtToDoControllerUsername.text = "";
                          txtToDoControllerPassword.text = "";
                          _stateLogin = "";
                        });
                        //go to page after login
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: SafeArea(child: PageAfterLogin())));
                        return;
                        //check ràng buộc người dùng sai mk
                      } else if (username == txtToDoControllerUsername.text) {
                        //_stateLoginPasswordWrongPassword();
                        return;
                      }
                    }
                    //không rời vào các trường hợp trên thì báo tk ko tồn tại
                    //_stateLoginPasswordNotExist();
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.04,
            ),
            alignment: Alignment.center,
            child: Text(
              "Forgot your password?",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
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
  String _stateLogin =
      ""; // để chứa thông tin về các trạng thái đăng nhập đúng sai
  late TextEditingController txtToDoControllerUsername;
  late TextEditingController txtToDoControllerPassword;

  void _stateLoginPasswordEmpty() {
    setState(() {
      _stateLogin = "Username or password must not be empty";
    });
  }

  void _stateLoginPasswordWrongPassword() {
    setState(() {
      _stateLogin = "Wrong password";
    });
  }

  void _stateLoginPasswordNotExist() {
    setState(() {
      _stateLogin = "This account is not exist";
    });
  }

  @override
  void initState() {
    super.initState();
    //vừa hiện widget là khởi tạo controller để người dùng nhập vào
    txtToDoControllerUsername = TextEditingController();
    txtToDoControllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    LoginDataConverter loginDataConvert =
        Provider.of<LoginDataConverter>(context);
    loginDataConvert.initData(); // lấy dữ liệu đăng nhập từ local storage
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 100,
            ),
            child: Text("GSOT", style: titleAppGsotLoginPage),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: textFormFieldLoginRegisterPage(txtToDoControllerUsername,
                "Username", false, Icons.account_circle),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: textFormFieldLoginRegisterPage(
                txtToDoControllerPassword, "Password", true, Icons.lock),
          ),
          stateLoginRegisterName(context, _stateLogin),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              style: buttonStyleLogin,
              onPressed: () {
                //check điều kiện người dùng bỏ trống 1 trong 2 username và password
                if (txtToDoControllerUsername.text == "" ||
                    txtToDoControllerPassword.text == "") {
                  _stateLoginPasswordEmpty(); //gọi hàm setstate trong hàm này và xuất ra message
                  return;
                }
                try {
                  //vì thiết bị có thể có nhìu hơn 1 tk đăng nhập nên chỗ này phải có for
                  for (int i = 0;
                      i < loginDataConvert.listUserLogins.length;
                      i++) {
                    var idUser = loginDataConvert.listUserLogins[i].user!.id;
                    var username =
                        loginDataConvert.listUserLogins[i].username.toString();
                    var password =
                        loginDataConvert.listUserLogins[i].password.toString();
                    if (username == txtToDoControllerUsername.text &&
                        password == txtToDoControllerPassword.text) {
                      //save session
                      loginDataConvert.setIdUser(idUser!);
                      //dang nhap thanh cong thi xoa canh bao
                      setState(() {
                        txtToDoControllerUsername.text = "";
                        txtToDoControllerPassword.text = "";
                        _stateLogin = "";
                      });
                      //go to page after login
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: SafeArea(child: PageAfterLogin())));
                      return;
                      //check ràng buộc người dùng sai mk
                    } else if (username == txtToDoControllerUsername.text) {
                      _stateLoginPasswordWrongPassword();
                      return;
                    }
                  }
                  //không rời vào các trường hợp trên thì báo tk ko tồn tại
                  _stateLoginPasswordNotExist();
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text(
                "Sign in",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              style: buttonStyleLogin,
              onPressed: () {
                onPressButtonRegister();
              },
              child: Text(
                "Sign up",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPressButtonRegister() {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: SafeArea(
          child: RegisterProviderUI(),
        ),
      ),
    );
  }
}
