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
              height: MediaQuery.of(context).size.height*0.3,
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Image.network(loginDataConvert.loginDataConverter.cover.toString()),
            )
        ),
        Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height*0.4,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white70,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {

                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white70,
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              ),
            )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height*0.25,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 90.0,
                      height: 90.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: NetworkImage(loginDataConvert.loginDataConverter.picture.toString()),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all( Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 90.0,
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 60,
                                width: 80,
                                decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: -5.0,
                                        blurRadius: 20,
                                      ),
                                    ]
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("100k",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("Posts"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 60,
                                width: 80,
                                decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: -5.0,
                                        blurRadius: 20,
                                      ),
                                    ]
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("100k",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("Followers"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 60,
                                width: 80,
                                decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: -5.0,
                                        blurRadius: 20,
                                      ),
                                    ]
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("100k",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("Following"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 60,
                                decoration: const ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: -5.0,
                                        blurRadius: 20,
                                      ),
                                    ]
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                                  onPressed: () {

                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loginDataConvert.loginDataConverter.name.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Text(loginDataConvert.loginDataConverter.nickname.toString(), style: const TextStyle(fontSize: 15),)
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.43,
                  color: Colors.red,
                  child: ListView(
                    children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data100"),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

