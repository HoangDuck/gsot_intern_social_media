import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

final List<String> imgList = [
  "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
  "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
  "https://raw.githubusercontent.com/Sameera-Perera/flutter-carousel-slider-example/master/home.png",
  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
  "http://www.androidcoding.in/wp-content/uploads/flutter_image_slider-1024x1024.png",
];

class SlideImages extends StatelessWidget {
  const SlideImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: imgList.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: imgList[index].contains("http")
                ? NetworkImage(
                    imgList[index],
                  )
                : FileImage(
                    File(imgList[index]),
                  ) as ImageProvider,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.contained * 2,
          );
        },
        loadingBuilder: (context, event) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
