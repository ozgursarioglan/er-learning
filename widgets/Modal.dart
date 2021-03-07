import 'package:flutter/material.dart';

class Modal extends StatefulWidget {
   Modal({
    Key key,
    this.elements,
    this.icon,
    this.color
  }) : super(key: key);

  final Widget elements;
  final Widget icon;
  final Color color;

  @override
  _Modal createState() => _Modal();
}

class _Modal extends State<Modal> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(100, 0, 0, 0),
        child:Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(20),
                topLeft: const Radius.circular(20),
              ),
              color: Theme.of(context).canvasColor
          ),
          child:Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height:50.0,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: const Radius.circular(20),
                      topLeft: const Radius.circular(20),
                    ),
                    color: widget.color,            
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: widget.icon
                )
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(children: <Widget>[
                      widget.elements
                    ],)
                  )
                )
              )
            ],
          )
        )
      );
  }
}