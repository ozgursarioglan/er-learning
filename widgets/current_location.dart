
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  CurrentLocation({Key key}) : super(key: key);


  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {

   String _address;
  double _latitude;
  double _longitude;

  @override
  void initState() {
    super.initState();
    setState((){
      _address = "Konum bekleniyor...";
    });
    _getCurrentLocation();
  }
  

  void _getCurrentLocation() async {
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState((){
      _latitude = position.latitude;
      _longitude = position.longitude;
    });    
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    
    Placemark place = placemarks[0];
    setState((){
      _address = "${place.street}, ${place.subThoroughfare}, ${place.locality}, ${place.postalCode}";
    });

  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(
            children: [
              Container(
                width:30,
                child:Icon(
                  Icons.location_searching,
                  color: Colors.black,
                )
              ),
              Flexible(
                flex:1,
                child: Text(
                    _address
                )
              )
            ],
          ),
          Row(
            children: [
              Container(
                width:30,
              ),
              Flexible(
                flex:1,
                child: Text(
                  "Konum değiştirmek için tıklayın",
                  style: new TextStyle( color: Colors.blue )
                )
              )
            ],
          ),
      ]
    );
  }
}
