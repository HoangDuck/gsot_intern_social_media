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
  static String getPathIconReactionIndex(dynamic whichIconUserChoose){
    switch (whichIconUserChoose) {
      case 1:
        return ic_like2;
      case 2:
        return ic_heart2;
      case 3:
        return ic_haha2;
      case 4:
        return ic_wow2;
      case 5:
        return ic_sad2;
      case 6:
        return ic_angry2;
      default:
        return ic_thumb_up2;
    }
  }
  static String getTextReaction(dynamic whichIconUserChoose){
    switch (whichIconUserChoose) {
      case 1:
        return 'Like';
      case 2:
        return 'Love';
      case 3:
        return 'Haha';
      case 4:
        return 'Wow';
      case 5:
        return 'Sad';
      case 6:
        return 'Angry';
      default:
        return 'Like';
    }
  }
}