import 'package:flutter/material.dart';

popupSuccess(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
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
                  children: const [
                    SizedBox(height:20,),
                    Center(
                      child: Text(
                        "Create account success",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Icon(Icons.check_circle_sharp,color: Colors.white,size: 50,),
                    SizedBox(height:20,),
                  ],
                ),
              ),
            ],
          ),
        );
      });
}
