import 'package:flutter/material.dart';
class Emotions extends StatelessWidget {
  const Emotions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      width: double.infinity,
      fit: BoxFit.fill,
      image: AssetImage('assets/images/giphy.webp'),
    );
  }
}
