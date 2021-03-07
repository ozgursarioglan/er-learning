import 'package:flutter/material.dart';
import '../models/pin_pill_info.dart';

class MapPinPillComponent extends StatefulWidget {

  double pinPillPosition;
  PinInformation currentlySelectedPin;

  MapPinPillComponent({ this.pinPillPosition, this.currentlySelectedPin});

  @override
  State<StatefulWidget> createState() => MapPinPillComponentState();
}

class MapPinPillComponentState extends State<MapPinPillComponent> {
  
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.currentlySelectedPin.prediction);
    String remainingText = widget.currentlySelectedPin.prediction==0 ? "Mama tükendü" : widget.currentlySelectedPin.prediction < 1.0 ? "Tahmini ${((widget.currentlySelectedPin.prediction*0.6)*100).toInt().round()} dakikada tükenecek" : "Tahmini ${widget.currentlySelectedPin.prediction.toInt().round()} saatte tükenecek";
    return AnimatedPositioned(
        bottom: widget.pinPillPosition,
        right: 0,
        left: 0,
        duration: Duration(milliseconds: 200),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: <BoxShadow>[
                  BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))
                ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50, height: 50,
                    margin: EdgeInsets.only(left: 10),
                    child: ClipOval(child: Image.asset(widget.currentlySelectedPin.pinPath, fit: BoxFit.cover )),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${widget.currentlySelectedPin.foodAmount.toInt().round()} gr. kaldı", style: TextStyle( color : Colors.blue )),
                          Text( remainingText )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
  }

}