import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media/ui/widget/show_full_image_widget.dart';

Widget listImagesWidget(
    BuildContext context, List<String> list, int numberOfImages) {
  if (numberOfImages == 0) {
    return Container();
  } else if (numberOfImages == 1) {
    return Center(
      child: showImageWidget(context, list[0]),
    );
  } else if (numberOfImages == 2) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: showImageWidget(context, list[0]),
        ),
        Expanded(
          flex: 1,
          child: showImageWidget(context, list[1]),
        )
      ],
    );
  } else if (numberOfImages == 3) {
    return Column(
      children: [
        showImageWidget(context, list[0]),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[1]),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[2]),
            )
          ],
        ),
      ],
    );
  } else if (numberOfImages == 4) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[0]),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[1]),
            )
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[2]),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[3]),
            )
          ],
        ),
      ],
    );
  } else if (numberOfImages > 4) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[0]),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[1]),
            )
          ],
        ),
        Divider(
          color: Colors.transparent,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: showImageWidget(context, list[2]),
            ),
            VerticalDivider(
              color: Colors.transparent,
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  showImageWidget(context, list[3]),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.white,
                            ),
                            Text(
                              "${numberOfImages - 4}",
                              style: TextStyle(
                                fontSize: 40,
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
            )
          ],
        ),
      ],
    );
  }
  return Container();
}

Widget showImageWidget(BuildContext context, String pathImage) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowFullImageWidget(
            pathImage: pathImage,
          ),
        ),
      );
    },
    child: Image.network(
      pathImage,
      errorBuilder: (context, error, stacktrace) {
        if (pathImage == "") {
          return Container();
        }
        return Image.file(
          File(pathImage),
          errorBuilder: (context, error, stacktrace) {
            return Container();
          },
        );
      },
    ),
  );
}
