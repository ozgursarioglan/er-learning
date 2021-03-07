
import 'package:flutter/material.dart';

class AutoMode extends StatefulWidget {
  AutoMode({Key key}) : super(key: key);

  @override
  _AutoMode create() => _AutoMode();

  @override
  State<StatefulWidget> createState() =>_AutoMode();
}


class _AutoMode extends State<AutoMode> {
  bool autoMode;
  @override
  void initState() {
    super.initState();
    setState(() {
      autoMode=true;
    });
  }

  @override
  Widget build(BuildContext context){
    return(
      Checkbox(
          value: autoMode, 
          onChanged: (bool value) {
            setState(() {
              autoMode = value;
            });
          },
        )
    );
  }
}