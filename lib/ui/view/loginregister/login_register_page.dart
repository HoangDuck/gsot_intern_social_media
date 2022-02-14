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

import 'package:social_media/ui/widget/circle_social_media.dart';
import 'package:social_media/ui/widget/textformfield_login_register.dart';

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
            return TabPages();
          }
          return Provider<LoginDataConverter>.value(
            value: LoginDataConverter(),
            child: Material(
              child: FormLoginUI(),
            ),
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
    //giá trị mặc định là -1, khác -1 là có dữ liệu của user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = -1;
    id = prefs.getInt('id') ?? -1;
    return id;
  }
}

class FormLoginUI extends StatefulWidget {
  const FormLoginUI({Key? key}) : super(key: key);

  @override
  _FormLoginUIState createState() => _FormLoginUIState();
}

class _FormLoginUIState extends State<FormLoginUI> {
  bool signInPress = true;
  bool signUpPress = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                        Image(
                          image: AssetImage('assets/images/logo.png'),
                        ),
                        FormField(
                          signInPress: signInPress,
                          signUpPress: signUpPress,
                        ),
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
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 38,
                              color: Color(0xff6d6a6d),
                              fontWeight: FontWeight.w300),
                        ),
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
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 7),
                            child: iconCircleSocialMedia(
                              LineIcons.facebookF,
                              Color(0xff516EAB),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 7, right: 7),
                            child: iconCircleSocialMedia(
                              LineIcons.googleLogo,
                              Color(0xffDD4B39),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 7),
                            child: iconCircleSocialMedia(
                              LineIcons.twitter,
                              Color(0xff00A6D3),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.3,
          right: MediaQuery.of(context).size.width / 2 + 10,
          child: FloatingActionButton.extended(
            onPressed: () {
              setState(
                () {
                  signInPress = true;
                  signUpPress = false;
                },
              );
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
            backgroundColor:
                signInPress ? Color(0xffff2c55) : Color(0xffe3e3e3),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.3,
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
            backgroundColor:
                signUpPress ? Color(0xffff2c55) : Color(0xffe3e3e3),
          ),
        ),
      ],
    );
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
  // String _stateLogin =
  //     ""; // để chứa thông tin về các trạng thái đăng nhập đúng sai
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
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
            ),
            child: textFormFieldLoginRegister(
              context,
              txtToDoControllerUsername,
              false,
              LineIcons.user,
              "Username",
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: textFormFieldLoginRegister(
              context,
              txtToDoControllerPassword,
              true,
              LineIcons.lock,
              "Password",
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: textFormFieldLoginRegister(
              context,
              txtToDoControllerRetypePass,
              true,
              LineIcons.lock,
              "Retype Password",
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
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
            ),
            child: textFormFieldLoginRegister(
              context,
              txtToDoControllerUsername,
              false,
              LineIcons.user,
              "Username",
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: textFormFieldLoginRegister(
              context,
              txtToDoControllerPassword,
              true,
              LineIcons.lock,
              "Password",
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
                  loginOnPressed(context, loginDataConverter);
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
          ),
        ],
      ),
    );
  }

  void loginOnPressed(
      BuildContext context, LoginDataConverter loginDataConverter) {
    //check điều kiện người dùng bỏ trống 1 trong 2 username và password
    if (txtToDoControllerUsername.text == "" ||
        txtToDoControllerPassword.text == "") {
      //_stateLoginPasswordEmpty();//gọi hàm setstate trong hàm này và xuất ra message
      return;
    }
    try {
      //vì thiết bị có thể có nhìu hơn 1 tk đăng nhập nên chỗ này phải có for
      for (int i = 0; i < loginDataConverter.listUserLogins.length; i++) {
        var idUser = loginDataConverter.listUserLogins[i].user!.id;
        var username = loginDataConverter.listUserLogins[i].username.toString();
        var password = loginDataConverter.listUserLogins[i].password.toString();
        if (username == txtToDoControllerUsername.text &&
            password == txtToDoControllerPassword.text) {
          //save session
          loginDataConverter.setIdUser(idUser!);
          //dang nhap thanh cong thi xoa canh bao
          setState(() {
            txtToDoControllerUsername.text = "";
            txtToDoControllerPassword.text = "";
            //_stateLogin = "";
          });
          //go to page after login
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: SafeArea(
                child: TabPages(),
              ),
            ),
          );
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
  }
}
