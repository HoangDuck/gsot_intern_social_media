import 'dart:convert';

import 'package:social_media/json_string/json_string_profile.dart';
import 'package:social_media/model/user_profile.dart';

final String profileData=profile;
class ProfileDataConverter{
  late final UserProfile profileDataConverter;
  ProfileDataConverter();
  initData(){
    Map<String, dynamic> map=jsonDecode(profileData);
    var userProfile=UserProfile.fromJson(map);
    profileDataConverter=userProfile;
  }
}