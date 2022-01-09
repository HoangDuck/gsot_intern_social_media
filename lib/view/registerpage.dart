import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/converter/login_data_converter.dart';
import 'package:social_media/converter/profile_data_converter.dart';
//import 'package:page_transition/page_transition.dart';
class RegisterProviderUI extends StatelessWidget {
  const RegisterProviderUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        body:
        MultiProvider(
        providers: [
          Provider<LoginDataConverter>.value(value: LoginDataConverter()),
          Provider<DataConvert>.value(value: DataConvert()),
          Provider<ProfileDataConverter>.value(value: ProfileDataConverter()),
        ],
          child:Register()
        ));
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _stateRegister="";
  String _stateRegisterName="";
  late TextEditingController txtToDoControllerName;
  late TextEditingController txtToDoControllerNickName;
  late TextEditingController txtToDoControllerUsername;
  late TextEditingController txtToDoControllerPassword;
  void _stateRegisterNameEmpty() {
    setState(() {
      _stateRegisterName="Full-name must not be empty";
    });
  }
  void _stateRegisterPasswordEmpty() {
    setState(() {
      _stateRegister="Username or password must not be empty";
    });
  }
  void _stateRegisterAccountExist() {
    setState(() {
      _stateRegister="This account is exist";
    });
  }
  @override
  void initState() {
    super.initState();
    //vừa hiện widget là khởi tạo controller để người dùng nhập vào
    txtToDoControllerName= TextEditingController();
    txtToDoControllerNickName= TextEditingController();
    txtToDoControllerUsername= TextEditingController();
    txtToDoControllerPassword= TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(20),
          child: buildRegisterPage(),
      );
  }
  Widget buildRegisterPage(){
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    dataConvert.initData();
    LoginDataConverter loginDataConverter=Provider.of<LoginDataConverter>(context);
    loginDataConverter.initData();
    ProfileDataConverter profileDataConverter=Provider.of<ProfileDataConverter>(context);
    profileDataConverter.initData();
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50,bottom: 50,),
          child: Text("Register",
            style: TextStyle(
                fontSize: 60,
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
          controller: txtToDoControllerName,
            decoration: const InputDecoration(
              labelText: "Full-name(*)",
              border: OutlineInputBorder( //Outline border type for TextField
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            )
        ),
        Container(
          //container để hiện statelogin nếu người dùng đăng nhập có vấn đề như sai mk hoặc username
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(2.5),
          child: Text(_stateRegisterName,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        ),
        TextFormField(
          controller: txtToDoControllerNickName,
          decoration: const InputDecoration(
            labelText: "Nickname",
            border: OutlineInputBorder( //Outline border type for TextField
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
        ),
        Container(
          //container để hiện statelogin nếu người dùng đăng nhập có vấn đề như sai mk hoặc username
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
        ),
        TextFormField(
          controller: txtToDoControllerUsername,
            decoration: const InputDecoration(
              labelText: "Username(*)",
              border: OutlineInputBorder( //Outline border type for TextField
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            )
        ),
        Container(
          //container để hiện statelogin nếu người dùng đăng nhập có vấn đề như sai mk hoặc username
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
        ),
        TextFormField(
          controller: txtToDoControllerPassword,
          decoration: const InputDecoration(
            labelText: "Password(*)",
            border: OutlineInputBorder( //Outline border type for TextField
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          obscureText: true,
        ),
        Container(
          //container để hiện statelogin nếu người dùng đăng nhập có vấn đề như sai mk hoặc username
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(2.5),
          child: Text(_stateRegister,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
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
              _stateRegisterPasswordEmpty();//gọi hàm setstate trong hàm này và xuất ra message
            }
            if(txtToDoControllerName.text==""){
              _stateRegisterNameEmpty();
              return;
            }
            try{
              //vì thiết bị có thể có nhìu hơn 1 tk đăng nhập nên chỗ này phải có for
              for(int i=0;i<loginDataConverter.listUserLogins.length;i++){
                var username=loginDataConverter.listUserLogins[i].username.toString();
                //var password=loginDataConverter.listUserLogins[i].password.toString();
                if(username==txtToDoControllerUsername.text){
                  //kiem tra username va password co su dung chua
                  _stateRegisterAccountExist();
                  return;
                }
              }
              //không rời vào các trường hợp trên thì tk có thể đăng kí được.
              String name=txtToDoControllerName.text;
              String? nickname=txtToDoControllerNickName.text.toString();
              String username=txtToDoControllerUsername.text;
              String password=txtToDoControllerPassword.text;
              //chen du lieu avatar vao local storage
              insertDataUserIntoLocalStorage(dataConvert, name, nickname);
              //chen du lieu user login vao local storage
              insertDataUserLoginIntoLocalStorage(loginDataConverter, name, nickname, username, password);
              //chen du lieu user profile vao local storage

              insertDataUserProfileIntoLocalStorage(profileDataConverter, name, nickname);
            }catch(e){
              log(e.toString());
            }
          },
          child:
          Container(
            color: Colors.blue,
            child: const Center(
              child: Text("Create account",style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Text("*: infomation must not be empty",style: TextStyle(color: Colors.red),),
          ),
        )
      ],
    );
  }
  insertDataUserIntoLocalStorage(DataConvert dataConvert,String name, String nickname)async{
    await dataConvert.insertDataUserAvatar(name, nickname);
  }
  insertDataUserLoginIntoLocalStorage(LoginDataConverter loginDataConverter,String name,String nickname, String username,String password)async{
    await loginDataConverter.insertData(name, nickname,username,password);
  }
  insertDataUserProfileIntoLocalStorage(ProfileDataConverter profileDataConverter,String name,String nickname)async{
    await profileDataConverter.insertData(name, nickname);
  }
}
