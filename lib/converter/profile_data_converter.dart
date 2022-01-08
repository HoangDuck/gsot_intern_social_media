import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/json_string/json_string_profile.dart';
//import 'package:social_media/model/user_login.dart';
import 'package:social_media/model/user_profile.dart';

final String profileData=profile;
class ProfileDataConverter{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late UserProfile profileDataConverter=UserProfile();
  List<UserProfile> listUserProfiles=[];
  String stringData="";
  int idUser=0;
  ProfileDataConverter();
  initData()async{
    await _getStringDataSharedPreferences();
    Iterable l = jsonDecode(stringData);
    List<UserProfile> userProfiles = List<UserProfile>.from(l.map((model)=> UserProfile.fromJson(model)));
    listUserProfiles.addAll(userProfiles);
    profileDataConverter=getCurrentUserProfile(listUserProfiles) as UserProfile;
    // Map<String, dynamic> map=jsonDecode(stringData);
    // var userProfile=UserProfile.fromJson(map);
    // profileDataConverter=userProfile;
  }
  Future<void> _getStringDataSharedPreferences() async {
    SharedPreferences prefs = await _prefs;
    stringData = prefs.getString('profileUserData') ?? profileData;
    prefs.setString('profileUserData',stringData);
  }
  Future<UserProfile?> getCurrentUserProfile(List<UserProfile> list) async{
    SharedPreferences prefs = await _prefs;
    int id=prefs.getInt('id')??0;
    for(int i=0;i<list.length;i++){
      if(list[i].id==id){
        return list[i];
      }
      return null;
    }
  }
}