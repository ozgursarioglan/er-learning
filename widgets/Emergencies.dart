import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'help_box.dart';
import 'package:http/http.dart' as http;


class Emergencies extends StatefulWidget {
  Emergencies({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EmergenciesState createState() => _EmergenciesState();
}

class _EmergenciesState extends State<Emergencies> {

  List data;

  Position location;

  @override
  void initState() {
    super.initState();
    getEmergency();
    _getCurrentLocation();
  }

 
  Future<String> getEmergency() async{
    final response =
      await http.get('https://dirty-paws.ey.r.appspot.com/emergency/');

      if (response.statusCode == 200) {
        List<dynamic> result = json.decode(utf8.decode(response.bodyBytes));
       
        setState((){
          data = result;
        });
      } else {
        throw Exception('Failed to load emergencies');
      }
  }

  _getCurrentLocation() async {
      location = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          shrinkWrap: true,
          itemCount: null==data ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            return HelpBox(
                message: data[index]['message'],
                status: data[index]['status'],
                owner_id: data[index]['owner_id'],
                user_id: data[index]['user_id'],
                longitude: data[index]['Longitude'],
                latitude: data[index]['Latitude'],
                location_id: data[index]['Location_Id'],
                location: location
            );
          },
      );
  }

}
