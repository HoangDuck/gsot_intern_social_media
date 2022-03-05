import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowFullImageWidget extends StatelessWidget {
  String pathImage = "";

  ShowFullImageWidget({Key? key, required this.pathImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: PhotoView(
            imageProvider: pathImage.contains("http")
                ? NetworkImage(
                    pathImage,
                  )
                : FileImage(
                    File(pathImage),
                  ) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
