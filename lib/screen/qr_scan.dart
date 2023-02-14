
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scan/screen/home.dart';
class scan extends StatefulWidget {
  @override
  _scanState createState() => _scanState();
}
class _scanState extends State<scan> {
  String _scanBarcode = '';
  @override
  void initState() {
    super.initState();
  }
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.black,
                leading:
                InkWell(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);
                    }, child: Icon(Icons.arrow_back)),
                title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  //  width: MediaQuery.of(context).size.width * 1.0,
                    height: MediaQuery.of(context).size.height * 1.0,
                    alignment: Alignment.center,
                    child: Flex(
                        direction: Axis.vertical,
                       // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                            child: Container(
                              child: Text('Scan result : $_scanBarcode\n',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          InkWell(
                            onTap: () async{;
                              setState(() {
                                scanQR();
                              });
                            },
                            child:
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    gradient: LinearGradient(colors: [
                                      Colors.black,
                                      Colors.black,
                                      Colors.black
                                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                                  ),
                                  padding: EdgeInsets.fromLTRB(120, 10, 120, 10,),
                                  child: Text(
                                    "QR Code Scan",
                                    style: TextStyle(
                                      //fontSize: 20,
                                        color: Colors.white,fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              //],
                           // ),
                          ),

                        ]
                    )
                ),
              );
            })));
  }
}
