import 'package:flutter/material.dart';
class HelpBox extends StatefulWidget {
   HelpBox({
    Key key,
    this.status,
    this.message,
    this.distance,
  }) : super(key: key);


  final String message;
  int status;
  int distance;

  @override
  _HelpBox createState() => _HelpBox();
}

class _HelpBox extends State<HelpBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text(
        "Acil durum bildirimi"
      )
    );
  }
}