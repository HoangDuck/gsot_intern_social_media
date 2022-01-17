import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/view/uploadstatus.dart';

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
                      child: Text(
                      "Upload",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
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
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff9796F0),
                                      Color(0xffFBC7D4),
                                    ],
                                  ),
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
                                        const Text(
                                          "Photo",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                          ),
                                        ),
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
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff9796F0),
                                      Color(0xffFBC7D4),
                                    ],
                                  ),
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
                                        const Text(
                                          "Status",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
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
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xff9796F0),
                                      Color(0xffFBC7D4),
                                    ],
                                  ),
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
                                        const Text(
                                          "Video",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
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
