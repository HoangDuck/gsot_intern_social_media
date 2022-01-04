import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dto/login_data_converter.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<LoginDataConverter>.value(
      value: LoginDataConverter(),
      child: InfoProfile(),
    );
  }
}
class InfoProfile extends StatelessWidget {
  const InfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginDataConverter loginDataConvert=Provider.of<LoginDataConverter>(context);
    loginDataConvert.initData();
    return Stack(
      children: [
        Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height*0.4,
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Image.network(loginDataConvert.loginDataConverter.cover.toString()),
            )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height*0.35,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                  ),
                ),
                child: SizedBox(
                  height: 350.0,
                  child: Row(
                    children: const [
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

