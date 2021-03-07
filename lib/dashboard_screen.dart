import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'feed.dart';
import 'widgets/Modal.dart';
import 'widgets/checkbox.dart';

import 'widgets/current_location.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dirty Paws',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Dashboard(title: 'Dirty Paws'),
    );
  }
}

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {



  @override
  void initState() {
    super.initState();
  }


  File _image;
  bool isImageSelected = false;
  final picker = ImagePicker();

  Future _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        setState((){
          _image = File(pickedFile.path);
          isImageSelected = true;
        });
      } else {
        print('No image selected.');
      }
      Navigator.of(context).pop();
    });
  }
  Future _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        setState((){
          _image = File(pickedFile.path);
          isImageSelected = true;
        });
      } else {
        print('No image selected.');
      }
      Navigator.of(context).pop();
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder:( BuildContext context) {
      return AlertDialog(
        title: Text("Fotoğraf çek veya yükle"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Galeri"),
                onTap: (){
                  _openGallery(context);
                }
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Kamera"),
                onTap: () {
                  _openCamera(context);
                }
              )
            ],
          )
        )
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Align( alignment: Alignment.center, child: Text(widget.title) )
        ),
        body: Feed(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){ showModal(); },
          tooltip: 'Increment',
          child: Icon(Icons.car_rental),
          backgroundColor: Color.fromARGB(255,235,87,87),
        ), 
      ),
    );
  }


  void showModal() {
    showModalBottomSheet(
      context: context, 
      barrierColor: Color.fromARGB(100, 0, 0, 0),
      isScrollControlled: true,
      builder: (context){
      return Modal(
        elements: Column(children: <Widget>[
          Row(
            children: [
              Container(
                width:30,
                child:AutoMode()
              ),
              Text(
                "Otomatik Paylaş",
                
              )
            ],
          ),
          CurrentLocation(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only( top: 20 ),
            height:50,
            child: 
              Material(
                elevation: 20.0,
                shadowColor: Color.fromARGB(100, 0, 0, 0),
                child: TextField(
                  maxLines: 2,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Açıklama girmek için tıklayın',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 10, top:10),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 3.0))
                  ),
                ),
              )  
          ),
          isImageSelected==true ? Container(padding: EdgeInsets.only(top:20), width:double.infinity, child: Image.file(_image, height:150)) : Text(""),
          GestureDetector(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Container(
              width: double.infinity,
              height:50,
              margin: EdgeInsets.only(top: 20),
              color: Color.fromARGB(10, 0, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black54
                      ),
                      Text(
                        "Fotoğraf seç"
                      )
                    ],
                )
               ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:20),
            child:FloatingActionButton(onPressed: () {

              },
              
              backgroundColor: Colors.green,
              child: Icon(
                Icons.send_outlined,
                color: Colors.white
              ),
            )
          )
        ]),
        color: Colors.red,
        icon: Icon(Icons.car_rental, color: Colors.white)
      );
    });
  }
}
