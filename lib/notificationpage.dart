import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/model/notifiers.dart';

import 'dto/data_converter.dart';
class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Notifications",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0.0,
                          blurRadius: 20,
                        ),
                      ]
                  ),
                  child: IconButton(
                    color: Colors.black,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ListNotifications(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListNotifications extends StatefulWidget {
  const ListNotifications({Key? key}) : super(key: key);

  @override
  _ListNotificationsState createState() => _ListNotificationsState();
}

class _ListNotificationsState extends State<ListNotifications> {
  @override
  Widget build(BuildContext context) {
    DataConvert dataConvert=Provider.of<DataConvert>(context);
    return Expanded(
        child: ListView.builder(
          itemCount: dataConvert.listNotifiers.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,i)
          {
            Notifier notifier=dataConvert.listNotifiers[i];
            if(i==0){
              return _buildTitleNew();
            }else{

            }
            return _buildRow(notifier);
          },
        ),
    );
  }
  Widget _buildRow(Notifier data) {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: -9,
                  blurRadius: 15,
                ),
              ]
          ),
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(data.user!.picture.toString())
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(text: data.user!.name.toString()+" ", style: const TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: data.content.toString()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(data.time.toString(), style: const TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
  Widget _buildTitleNew(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 15,),
        Text(
          "New",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
  Widget _buildTitleEarlier(){
    return Column(
      children: const [
        SizedBox(height: 15,),
        Text(
          "Earlier",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
  Widget _buildTitleThisWeek(){
    return Column(
      children: const [
        SizedBox(height: 15,),
        Text(
          "This week",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}
