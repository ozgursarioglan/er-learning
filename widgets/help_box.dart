import '../users.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Modal.dart';
import '../map.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent/android_intent.dart';

class HelpBox extends StatefulWidget {
   HelpBox({
    Key key,
    this.status,
    this.message,
    this.owner_id,
    this.user_id,
    this.location_id,
    this.latitude,
    this.longitude,
    this.location
  }) : super(key: key);


  final String message;
  int status;
  int location_id;
  int user_id;
  int owner_id;
  final double latitude;
  final double longitude;
  final Position location;

  @override
  _HelpBox createState() => _HelpBox();
}

class _HelpBox extends State<HelpBox> {

  double _latitude;
  double _longitude;

  String distance;
  bool calculated = false;
  
  @override
  void initState() {
    super.initState();
  }

  Future<String> _getCurrentLocation() async {
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
       double _distance = await GeolocatorPlatform.instance.distanceBetween(widget.location.latitude, widget.location.longitude, widget.longitude, widget.latitude);
      return (_distance.toInt()/1000).round().toString();
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () => showModal(),
    child: new Container(
          height:120.0,
          margin: new EdgeInsets.only(left:20.0, right:20.0, bottom:20.0),
          decoration: new BoxDecoration(borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(15, 0, 0, 0),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
          child:  new Padding(
            padding: EdgeInsets.only(top:25.0, right:20.0, left:20.0, bottom:10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Column(
                    children: <Widget>[
                      new Expanded(
                        flex:2,
                        child: new Align(
                          alignment: Alignment.topLeft, 
                          child: Column(children: [
                           Container(
                            alignment: Alignment.topLeft,
                             child: Text( 
                              "${mockUsers[widget.owner_id-1]['name']} yardım istiyor" ,
                              style: new TextStyle(fontWeight: FontWeight.w600, fontSize:14)
                            ),
                           ),
                            Container(
                              alignment: Alignment.topLeft,
                              child:Text(
                               "${widget.message}",
                              style: new TextStyle(  fontSize: 14.0)
                            ))
                          ],)
                          )
                      ),
                      new Expanded(
                        flex:1,
                        child:new Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: new Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: (widget.status==1) ? Color.fromARGB(255, 235, 87, 87) : Color.fromARGB(255, 45, 156, 219),
                                      child:Icon(
                                        (widget.status==1) ? Icons.hourglass_top_outlined : Icons.car_repair,
                                        color: Colors.white,
                                        size: 18.0,
                                      ),
                                    ),
                                    Text(
                                      (widget.status==1) ? "Yardım Bekliyor" : "${mockUsers[widget.user_id]['name']} yolda"
                                    ),
                                  ],
                                )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: new Align(
                                  alignment: Alignment.centerRight, 
                                  child: 
                                     new FutureBuilder < String > (
                                        future: _getCurrentLocation(),
                                        builder: (context, snapshot) {
                                        if (snapshot.data==null) {
                                           return new Text("Mesafe hesaplanıyor...");
                                        }else
                                           return new Text("${snapshot.data} km. mesafe");
                                        }
                                    )
                                  )
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
      ),
    );
  }
  void showModal() {
    showModalBottomSheet(context: context, 
    barrierColor: Color.fromARGB(100, 0, 0, 0),
    builder: (context){
      return Modal(
        elements: Column(children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            child:Text(
              widget.message,
              style: new TextStyle(fontSize: 16),
            ),
          ),
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: (widget.status==1) ? Color.fromARGB(255, 235, 87, 87) : Color.fromARGB(255, 45, 156, 219),
                  child:Icon(
                    (widget.status==1) ? Icons.hourglass_top_outlined : Icons.car_repair,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:10),
                  child:Text(
                    (widget.status==1) ? "Yardım Bekliyor" : "Barış D. yolda"
                  )
                ),
              ],
            )
          ),
          Container(
            height:100,
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            child: EmergencyMap()
          ),
          RaisedButton(onPressed: (){},
            color: Colors.green,
            child:Text("Geliyorum", style: new TextStyle( color: Colors.white ))
          )
        ]),
        color: Colors.red,
        icon: Icon(Icons.car_rental, color: Colors.white)
      );
    });
  }
}