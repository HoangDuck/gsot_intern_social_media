import 'package:social_media/ui/constant/app_images.dart';

class Utils{
  static String getPathIconReaction(dynamic iconName){
    switch (iconName) {
      case 'Like':
        return ic_thumb_up;
      case 'Love':
        return ic_heart;
      case 'Haha':
        return ic_smile;
      case 'Wow':
        return ic_wow2;
      case 'Sad':
        return ic_weep;
      case 'Angry':
        return ic_angry2;
      default:
        return ic_thumb_up;
    }
  }
}