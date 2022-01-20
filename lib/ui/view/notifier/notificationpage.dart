import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/core/model/notifiers.dart';
import 'package:social_media/ui/constant/app_colors.dart';
import 'package:social_media/ui/constant/shapedecorationbuttonsearch.dart';

import '../../../core/converter/data_converter.dart';
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
                  decoration: shapeDecorationShadow(10),
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
    List<Notifier> listNotifiersNew=[];
    List<Notifier> listNotifiersEarlier=[];
    List<Notifier> listNotifiers=[];
    listNotifiers.addAll(dataConvert.listNotifiers);
    for(int i=0;i<dataConvert.listNotifiers.length;i++){
      if(dataConvert.listNotifiers[i].read=="false"){
        listNotifiersNew.add(dataConvert.listNotifiers[i]);
      }
      else {
        listNotifiersEarlier.add(dataConvert.listNotifiers[i]);
      }
    }
    listNotifiers.clear();
    listNotifiers.add(Notifier());
    listNotifiers.addAll(listNotifiersNew);
    listNotifiers.add(Notifier());
    listNotifiers.addAll(listNotifiersEarlier);
    return Expanded(
        child: ListView.builder(
          itemCount: listNotifiers.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,i)
          {
            Notifier notifier=listNotifiers[i];
            if(i==0){
              return _buildTitleNew();
            }else if(notifier.id==null){//vi list co 2 cho bi null ma cho
              // null dau tien da duoc xac dinh i=0 nen vi tri null 2 ko can
              // them index xac dinh
              return _buildTitleEarlier();
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
          child: SizedBox(
            child: Row(
              children: [
                const SizedBox(width: 10,),
                SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                      NetworkImage(data.user!.picture.toString()),
                      backgroundColor: Colors.transparent,
                    ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(text: data.user!.name.toString()+" ", style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: data.content.toString()),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(data.time.toString(), style: TextStyle(fontSize: 15),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
  Widget _buildTitleNew(){
    return columnFilter("New");
  }
  Widget _buildTitleEarlier(){
    return columnFilter("Earlier");
  }
  Widget columnFilter(String text){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorFilterNotifier,
          ),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}
