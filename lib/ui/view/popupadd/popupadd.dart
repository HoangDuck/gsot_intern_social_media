import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media/core/converter/data_converter.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/text_styles.dart';
import 'package:social_media/ui/view/homepage/uploadstatus.dart';

popupAdd(BuildContext context,DataConvert dataConvert){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Stack(
            children: <Widget>[
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(),
                ),
              ),
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Text("Upload", style: textSize20),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: colorPopupWidget,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  ),
                                ),
                                child: SizedBox(
                                  width: 65,
                                  height: 80,
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                    ),
                                    child:Column(
                                      children: [
                                        IconButton(
                                          color: Colors.white,
                                          icon: const Icon(Icons.image_outlined),
                                          onPressed: () {
                                          },
                                        ),
                                        const Text("Photo", style: textSize15White),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: colorPopupWidget,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  ),
                                ),
                                child: SizedBox(
                                  width: 65,
                                  height: 80,
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                    ),
                                    child:Column(
                                      children: [
                                        IconButton(
                                          color: Colors.white,
                                          icon: const Icon(Icons.sms_outlined),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.fade,
                                                    child: SafeArea(
                                                        child: ChangeNotifierProvider<DataConvert>.value(
                                                          value: dataConvert,
                                                            child: UploadStatus())
                                                    )
                                                )
                                            );
                                          },
                                        ),
                                        const Text("Status", style: textSize15White),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: colorPopupWidget,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 2
                                  ),
                                ),
                                child: SizedBox(
                                  width: 65,
                                  height: 80,
                                  child: Ink(
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                    ),
                                    child:Column(
                                      children: [
                                        IconButton(
                                          color: Colors.white,
                                          icon: const Icon(Icons.slideshow),
                                          onPressed: () {
                                          },
                                        ),
                                        const Text("Video", style: textSize15White),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height:50,),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
