import 'package:flutter/material.dart';
import 'package:scan/screen/Generator_qr.dart';
import 'package:scan/screen/qr_scan.dart';
import 'package:flutter/services.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);
  @override
  State<home> createState() => homeState();
}
class homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        //leading: Icon(Icons.document_scanner_outlined),
        title: Center(child: Text("QR Code")),),
      body: Container(
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 1.0,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50,left: 15,right: 15),
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Container(
                    child: Image(image: AssetImage("assets/images/scan.jpg"))),
              ),
              SizedBox(height: 80),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Generator()), (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                     // width: double.infinity,
                      height: 35,
                      margin: EdgeInsets.only(bottom: 5),
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
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //scanQR();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => scan()), (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // width: double.infinity,
                      height: 35,
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Scan QR Code",
                          style: TextStyle(
                            //fontSize: 20,
                              color: Colors.white,fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],),
          ),
        ),),
    );
  }
}
