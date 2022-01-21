import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/core/converter/data_converter.dart';
import 'package:social_media/core/converter/login_data_converter.dart';
import 'package:social_media/core/converter/profile_data_converter.dart';
import 'package:social_media/core/model/user.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/button_styles.dart';
import 'package:social_media/ui/view/notifier/popupsuccess.dart';
import 'package:social_media/ui/widget/containertext20white.dart';
import 'package:social_media/ui/widget/stateloginregistername.dart';
import 'package:social_media/ui/widget/textformfieldlogin.dart';
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
          ChangeNotifierProvider<DataConvert>.value(value: DataConvert()),
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
    initDataInProfile(profileDataConverter);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50,bottom: 50,),
          child: Text("Register",
            style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = colorTitleApp.createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
            ),
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: textFormFieldLoginRegisterPage(txtToDoControllerName,"Full-name",false,Icons.account_circle)
        ),
        stateLoginRegisterName(context, _stateRegisterName),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
            child: textFormFieldLoginRegisterPage(txtToDoControllerNickName,"Nickname",false,Icons.account_circle),
        ),
        containerPadding10(context),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
            child: textFormFieldLoginRegisterPage(txtToDoControllerUsername, "Username", false,Icons.account_circle),
        ),
        containerPadding10(context),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
            child: textFormFieldLoginRegisterPage(txtToDoControllerPassword, "Password", true,Icons.lock),
        ),
        stateLoginRegisterName(context,_stateRegister),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: ElevatedButton(
            style: buttonStyleLogin,
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
                insertData(dataConvert,loginDataConverter,profileDataConverter,name, nickname, username, password);
                setState(() {
                  //set state để không bị thông báo success khi người dùng nhấn 1 lần nữa
                  _stateRegister="";
                  _stateRegisterName="";
                  popupSuccess(context);
                });
              }catch(e){
                log(e.toString()+"HCMUTE");
              }
            },
            child: Text("Create account",style: TextStyle(fontWeight: FontWeight.bold),)
          ),
        )
      ],
    );
  }
  initDataInProfile(ProfileDataConverter profileDataConverter)async{
    await profileDataConverter.initData();
  }
  insertData(DataConvert dataConvert,LoginDataConverter loginDataConverter,ProfileDataConverter profileDataConverter,String name,String nickname,String username,String password)async{
    //chen du lieu avatar vao local storage
    User user=await insertDataUserIntoLocalStorage(dataConvert, name, nickname);
    //chen du lieu user login vao local storage
    await insertDataUserLoginIntoLocalStorage(loginDataConverter, user, username, password);
    //chen du lieu user profile vao local storage
    await insertDataUserProfileIntoLocalStorage(profileDataConverter,user);
  }
  Future<User>insertDataUserIntoLocalStorage(DataConvert dataConvert,String name, String nickname)async{
    User user=await dataConvert.insertDataUserAvatar(name, nickname);
    return user;
  }
  insertDataUserLoginIntoLocalStorage(LoginDataConverter loginDataConverter,User user, String username,String password)async{
    await loginDataConverter.insertData(user,username,password);
  }
  insertDataUserProfileIntoLocalStorage(ProfileDataConverter profileDataConverter,User user)async{
    await profileDataConverter.insertData(user);
  }
}