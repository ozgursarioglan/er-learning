import 'package:flutter/material.dart';
import 'food_map.dart';
import 'widgets/Emergencies.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child:GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodMap()),
              );
            },
              child: Container(
                width: double.infinity,
                height:50,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  color: Colors.green
                ),
                padding: EdgeInsets.only(top:5),
                child:Column(children: [
                  Icon( Icons.map_outlined, color:Colors.white),
                  Text( "Mama Haritası", style: new TextStyle( color: Colors.white ))
                ],)
              )
            )
          ),
        Padding(
          padding: EdgeInsets.only(top:5, left:20, bottom: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child:  Text(
              "Acil Durumlar",
              style: new TextStyle( fontSize: 22, fontWeight: FontWeight.w500)
            ),
          )
        ),
        Expanded( child: Emergencies() )
      ],
    );
  }
}
