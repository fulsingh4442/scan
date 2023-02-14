import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scan/screen/home.dart';
import 'package:scan/screen/qr_scan.dart';
class result extends StatefulWidget {
  const result({Key? key}) : super(key: key);
  @override
  State<result> createState() => resultState();
}
class resultState extends State<result> {
  TextEditingController usernameController = TextEditingController();
  String _scanBarcode = 'Unknown';
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(onTap: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => home()), (route) => false);
      },
          child: Icon(Icons.document_scanner_outlined)),title: Center(child: Text("QR Code")),actions: [Container(alignment: Alignment.center,margin: EdgeInsets.only(right: 15),
          child: InkWell(onTap: (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => scan()), (route) => false);

          },
              child: Text("New Scan",style: TextStyle(fontSize: 10),)))],

      ),
      body: Container(

        margin: EdgeInsets.only(top: 20,left: 15,right: 15),
        child: Column(children: [
          Text('Scan result : $_scanBarcode\n',
              style: TextStyle(fontSize: 20)),

        ],),),
    );
  }
}
