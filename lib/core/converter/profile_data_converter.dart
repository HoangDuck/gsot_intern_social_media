import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/json_string/json_string_profile.dart';
import 'package:social_media/core/model/user.dart';
import 'package:social_media/core/model/user_profile.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
final String profileData=profile;

class ProfileDataConverter{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  UserProfile profileDataConverter=UserProfile();
  List<UserProfile> listUserProfiles=[];
  String stringData="";
  int idUser=0;
  ProfileDataConverter();
  Future<bool> initData()async{
    await _getStringDataSharedPreferences();
    createListUserProfiles();
    profileDataConverter= await getCurrentUserProfile(listUserProfiles);
    return true;
  }
  createListUserProfiles(){
    Iterable l = jsonDecode(stringData);
    List<UserProfile> userProfiles = List<UserProfile>.from(l.map((model)=> UserProfile.fromJson(model)));
    listUserProfiles.clear();
    listUserProfiles.addAll(userProfiles);
    encodeJson(listUserProfiles);
  }
  Future<void> encodeJson(List<UserProfile> listUserProfiles) async {
    SharedPreferences prefs = await _prefs;
    var jsonUserProfiles=jsonEncode(listUserProfiles);
    prefs.setString('profileUserData',jsonUserProfiles);
  }
  Future<void> _getStringDataSharedPreferences() async {
    SharedPreferences prefs = await _prefs;
    stringData = prefs.getString('profileUserData') ?? profileData;
    prefs.setString('profileUserData',stringData);
  }
  Future<UserProfile> getCurrentUserProfile(List<UserProfile> list) async{
    SharedPreferences prefs = await _prefs;
    idUser=prefs.getInt('id')??1;
    for(int i=0;i<list.length;i++){
      if(list[i].user!.id==idUser){
        return list[i];
      }
    }
    return UserProfile();
  }
  insertData(User user)async{
    int id=listUserProfiles.length+1;
    var userProfile=UserProfile(id: id,user: user,posts: 0,follower: 0,following: 0,listImage: []);
    listUserProfiles.add(userProfile);
    encodeJson(listUserProfiles);
  }
  Future<void> deleteIdUser() async {
    SharedPreferences prefs = await _prefs;
    await prefs.setInt('id',-1);
  }
  // _write(String text) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final File file = File('${directory.path}/my_file.txt');
  //   await file.writeAsString(text);
  // }
}