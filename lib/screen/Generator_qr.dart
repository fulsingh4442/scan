import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/screen/home.dart';
import 'package:share/share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
// This package is used to save screenshots to the gallery
import 'package:image_gallery_saver/image_gallery_saver.dart';
class Generator extends StatefulWidget {
  const Generator({Key? key}) : super(key: key);
  @override
  State<Generator> createState() => _GeneratorState();
}
class _GeneratorState extends State<Generator> {
   TextEditingController name = TextEditingController();
   TextEditingController email = TextEditingController();
   TextEditingController mobile = TextEditingController();
  TextEditingController Address = TextEditingController();
   GlobalKey globalKey = new GlobalKey();
   String _message = '';
   File? file;
   void _takeScreenshot() async {
     RenderRepaintBoundary boundary =
     globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
     ui.Image image = await boundary.toImage();
     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
     if (byteData != null) {
       Uint8List pngBytes = byteData.buffer.asUint8List();
       // Saving the screenshot to the gallery
       final result = await ImageGallerySaver.saveImage(
           Uint8List.fromList(pngBytes),
           quality: 90,
           name: 'screenshot-${DateTime.now()}.png');
       if (kDebugMode) {
         print(result);
       }
       setState(() {
         _message = 'QR screenshot successfully!';
       });
     }
   }
   bool _isVisible = false;
   void hideWidget() {
     setState(() {
       _isVisible = !_isVisible;
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:
      InkWell(
          onTap: (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);
          }, child: Icon(Icons.arrow_back)),
        title: Center(child: Text(" QR Code Generator")),),
      body: Container(
        margin: EdgeInsets.only(top: 0,left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(children: [
            RepaintBoundary(
              key: globalKey,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 300,
                color: Colors.white,
                child: QrImage(
                  data: name.text
                      +  email.text.toString()  +
                      mobile.text.toString()  +
                      Address.text.toString(),
                  gapless: true,
                  size: 200,
                ),
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: TextButton(
                        onPressed:  _takeScreenshot,
                            child: const Text('QR Screenshot',style: TextStyle(color: Colors.white),)
                       // ),
                    ),
                  ),
                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 5),

                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: TextButton(
                      child: Text('Share',style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        try {
                          RenderRepaintBoundary boundary = globalKey.currentContext!
                              .findRenderObject() as RenderRepaintBoundary;
//captures qr image
                          var image = await boundary.toImage();
                          ByteData? byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                          Uint8List pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
                          final appDir = await getApplicationDocumentsDirectory();
//current time
                          var datetime = DateTime.now();
//qr image file creation
                          file = await File('${appDir.path}/$datetime.png').create();
//appending data
                          await file?.writeAsBytes(pngBytes);
//Shares QR image
                          await Share.shareFiles(
                            [file!.path],
                            mimeTypes: ["image/png"],
                            text: "Share the QR Code",
                          );
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    )
                  ),
                 // ),
                ],
              ),
            ),

            Container(
                margin: EdgeInsets.only(top: 5),

                child: Text(_message,style: TextStyle(color: Colors.black),)),
            SizedBox(height: 50),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: "name",labelStyle: TextStyle(color: Colors.black),
                  // fillColor: Colors.white,
                  // labelText: "Username1",labelStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.only(left: 15,),
                  hintText: 'name',
                  hintStyle: TextStyle( color: Colors.black,),

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "URL No cannot be empty";
                  }
                  return null;
                },
                autofocus: false,
                controller: name,
              ),
            ),
            Container(

              width: double.infinity,
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: "email ",labelStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: ' email ',
                  hintStyle: TextStyle( color: Colors.black),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "email No cannot be empty";
                  }
                  return null;
                },
                autofocus: false,
                controller: email,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),

              child: TextFormField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: " mobile ",labelStyle: TextStyle(color: Colors.black),
                  // fillColor: Colors.white,
                  // labelText: "Username1",labelStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: ' mobile ',
                  hintStyle: TextStyle( color: Colors.black),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "mobile No cannot be empty";
                  }
                  return null;
                },
                autofocus: false,
                controller: mobile,
              ),
            ),
            Container(
             // height: 60,
              width: double.infinity,
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              child: TextFormField(
                // },
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  labelText: " Address ",labelStyle: TextStyle(color: Colors.black),
                  // fillColor: Colors.white,
                  // labelText: "Username1",labelStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: ' Address ',
                  hintStyle: TextStyle( color: Colors.black),

                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Address No cannot be empty";
                  }
                  return null;
                },
                autofocus: false,
                controller: Address,
              ),
            ),
            SizedBox(height: 15,),
            InkWell(
              onTap: () {
                setState(() {
                   name.text.toString();email.text.toString();mobile.text.toString();
                   Address.text.toString();
                   hideWidget();

                 // usernameController.text.toString();
                });
                Timer(Duration(seconds: 1), () {
                  Address.clear();name.clear();email.clear();mobile.clear();
                });
              },
              child:
                  Container(
                    width: double.infinity,
                    height: 35,
                    margin: EdgeInsets.only(left: 15,right: 15,bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,

                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Generator QR Code",
                        style: TextStyle(

                          //fontSize: 20,
                            color: Colors.white,fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
               // ],
             // ),
            ),

          ],),
        ),),
    );
  }
}



