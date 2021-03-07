import 'dart:async';
import 'dart:convert';
import 'models/food_data.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/pin_pill_info.dart';
import 'widgets/pin_pill_info.dart';

class FoodMap extends StatefulWidget {
  FoodMap({Key key}) : super(key: key);

  @override
  _FoodMapState createState() => _FoodMapState();
}

class _FoodMapState extends State<FoodMap> {

  final CameraPosition vegasPosition = CameraPosition(target: LatLng(35.141091, 33.912788), zoom: 12);
  Set<Marker> allFoods= {};
  Completer<GoogleMapController> _controller = Completer();

  bool positionsCreated = false;
  bool markersCreated = false;
  BitmapDescriptor _grey;
  BitmapDescriptor _orange;
  BitmapDescriptor _red;
  BitmapDescriptor _green;

  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(foodAmount: 0, prediction:0, locationId: 0, pinPath: "assets/images/grey.png");
  PinInformation sourcePinInfo;
  PinInformation destinationPinInfo;

  List<PinInformation> allPins = List<PinInformation>();

  String redPath = "assets/images/red.png";
  String greyPath = "assets/images/grey.png";
  String orangePath = "assets/images/orange.png";
  String greenPath = "assets/images/green.png";

  @override
  void initState() {
    super.initState();
    initMarkers();
  } 
  void initMarkers()async{
    await createMarker();
    await createPositions();
    setState((){});
  }
  
  Future<List<FoodData>>_getLocations() async{
   final response =
      await http.get('https://dirty-paws.ey.r.appspot.com/remaining/');

      if (response.statusCode == 200) {
        return List<FoodData>.from(json.decode(response.body).map((x) => FoodData.fromJson(x)));

      } else {
        throw Exception('Failed to load album');
      }
  }


  void createMarker() async{
    _grey = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/grey.png');
    _green = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/green.png');
    _orange = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/orange.png');
    _red = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'assets/images/red.png');

  }

  void createPositions() async{
    List<FoodData> locations = await _getLocations();
    locations.forEach((item){
      allFoods.add(Marker(
        markerId: MarkerId(item.locationId.toString()),
        draggable: false,
        icon: item.prediction<=1 ? _red : item.prediction > 1 && item.prediction <= 3 ? _orange : _green,
        onTap: () {
            setState(() {
              currentlySelectedPin = allPins[item.locationId-1];
              pinPillPosition = 0;
            });
        },
        position: LatLng(item.longitude,item.latitude)
      ));
      
      
      allPins.add(
        PinInformation(
          locationId: item.locationId,
          foodAmount: item.foodAmountGr,
          prediction: item.prediction,
          pinPath: item.prediction<=1 ? redPath : item.prediction>1 && item.prediction <= 3 ? orangePath : greenPath
        )
      );
    });
  }
  void onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align( alignment: Alignment.centerRight, child: new Image.asset("assets/images/paws.png", width:30, height:30) )
      ),
      body:Stack(
          children: <Widget>[
            GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: vegasPosition,
                markers: allFoods,
                onMapCreated: onMapCreated,
            ),
            MapPinPillComponent(
                pinPillPosition: pinPillPosition,
                currentlySelectedPin: currentlySelectedPin
            )])
    );
  }
}
