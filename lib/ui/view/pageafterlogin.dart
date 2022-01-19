import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/converter/data_converter.dart';
import 'package:social_media/ui/view/chat/chat.dart';
import 'package:social_media/ui/view/homepage/homepage.dart';
import 'package:social_media/ui/view/notifier/notificationpage.dart';
import 'package:social_media/ui/view/popupadd/popupadd.dart';
import 'package:social_media/ui/view/profilepage/profilepage.dart';

class PageAfterLogin extends StatelessWidget {
  const PageAfterLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataConvert>.value(
      value: DataConvert(),
      child: Pages(),
    );
  }
}

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<DataConvert>(context).initData(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return buildHomePage(context);
        }
        return Container();
      },
    );
  }
  //UI Homepage
  Widget buildHomePage(BuildContext context){
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    return ChangeNotifierProvider<DataConvert>.value(
      value: dataConvert,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 75,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(0);
                    });
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  icon: const Icon(Icons.chat),
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(1);
                    });
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  icon: const Icon(Icons.my_library_add_rounded),
                  onPressed: () {
                    setState(() {
                      popupAdd(context,dataConvert);
                    });
                  },
                ),
                IconButton(
                    iconSize: 30.0,
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(3);
                      });
                    }
                ),
                IconButton(
                  iconSize: 30.0,
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () {
                    setState(() {
                      _myPage.jumpToPage(4);
                    });
                  },
                )
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _myPage,
          children: <Widget>[
            HomePage(),
            Container(
              padding: const EdgeInsets.all(10),
              child: ChatPage(),
            ),
            const Center(
              child: Text('Empty Body 2'),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: NotificationPage(),
            ),
            ProfilePage()
          ],
          physics: const NeverScrollableScrollPhysics(), // Comment this if you need to use Swipe.
        ),
      ),
    );
  }
}