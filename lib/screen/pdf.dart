// // import 'package:flutter/material.dart';
// // import 'package:qr_flutter/qr_flutter.dart';
// // import 'package:flutter/services.dart';
// // import 'dart:async';
// // import 'dart:typed_data';
// // import 'dart:ui';
// // import 'dart:io';
// // import 'package:flutter/rendering.dart';
// // import 'package:path_provider/path_provider.dart';
// //
// // class GenerateScreen extends StatefulWidget {
// //
// //   @override
// //   State<StatefulWidget> createState() => GenerateScreenState();
// // }
// //
// // class GenerateScreenState extends State<GenerateScreen> {
// //
// //   static const double _topSectionTopPadding = 50.0;
// //   static const double _topSectionBottomPadding = 20.0;
// //   static const double _topSectionHeight = 50.0;
// //
// //   GlobalKey globalKey = new GlobalKey();
// //   String _dataString = "Hello from this QR";
// //   //String _inputErrorText;
// //   final TextEditingController _textController =  TextEditingController();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('QR Code Generator'),
// //         actions: <Widget>[
// //           IconButton(
// //             icon: Icon(Icons.share),
// //             onPressed: _captureAndSharePng,
// //           )
// //         ],
// //       ),
// //       body: _contentWidget(),
// //     );
// //   }
// //
// //   Future<void> _captureAndSharePng() async {
// //     try {
// //       RenderRepaintBoundary? boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
// //       var image = await boundary!.toImage();
// //       ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
// //       Uint8List pngBytes = byteData!.buffer.asUint8List();       final tempDir = await getTemporaryDirectory();
// //       final file = await new File('${tempDir.path}/image.png').create();
// //       await file.writeAsBytes(pngBytes);
// //       final channel = const MethodChannel('channel:me.alfian.share/share');
// //       channel.invokeMethod('shareFile', 'image.png');
// //     } catch(e) {
// //       print(e.toString());
// //     }
// //   }
// //
// //   _contentWidget() {
// //     final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
// //     return  Container(
// //       color: const Color(0xFFFFFFFF),
// //       child:  Column(
// //         children: <Widget>[
// //           Padding(
// //             padding: const EdgeInsets.only(
// //               top: _topSectionTopPadding,
// //               left: 20.0,
// //               right: 10.0,
// //               bottom: _topSectionBottomPadding,
// //             ),
// //             child:  Container(
// //               height: _topSectionHeight,
// //               child:  Row(
// //                 mainAxisSize: MainAxisSize.max,
// //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// //                 children: <Widget>[
// //                   Expanded(
// //                     child:  TextField(
// //                       controller: _textController,
// //                       decoration:  InputDecoration(
// //                         hintText: "Enter a custom message",
// //                         //errorText: _inputErrorText,
// //                       ),
// //                     ),
// //                   ),
// //                   // Padding(
// //                   //   padding: const EdgeInsets.only(left: 10.0),
// //                   //   child:  FlatButton(
// //                   //     child:  Text("SUBMIT"),
// //                   //     onPressed: () {
// //                   //       setState((){
// //                   //         _dataString = _textController.text;
// //                   //         _inputErrorText = null;
// //                   //       });
// //                   //     },
// //                   //   ),
// //                   // )
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child:  Center(
// //               child: RepaintBoundary(
// //                 key: globalKey,
// //                 child: QrImage(
// //                   data: _dataString,
// //                   size: 0.5 * bodyHeight,
// //                   onError: (ex) {
// //                     print("[QR] ERROR - $ex");
// //                     setState((){
// //                       //_inputErrorText = "Error! Maybe your input value is too long?";
// //                     });
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:typed_data';
// import 'dart:ui';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share/share.dart';
// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter QR Code Generator With Share',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QRGeneratorSharePage(),
//     );
//   }
// }
// class QRGeneratorSharePage extends StatefulWidget {
//   const QRGeneratorSharePage({Key? key}) : super(key: key);
//   @override
//   _QRGeneratorSharePageState createState() => _QRGeneratorSharePageState();
// }
// class _QRGeneratorSharePageState extends State<qrgeneratorsharepage> {
//   final key = GlobalKey();
//   String textdata = 'androidride.com';
//   final textcontroller = TextEditingController();
//   File? file;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text('QR Code Generator With Share Example'),
//       ),
//       body: Column(
//         children: [
//           RepaintBoundary(
//             key: key,
//             child: Container(
//               color: Colors.white,
//               child: QrImage(
//                 size: 300,//size of the QrImage widget.
//                 data: textdata,//textdata used to create QR code
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: textcontroller,
//             ),
//           ),
//           ElevatedButton(
//             child: Text('Create QR Code'),
//             onPressed: () async {
//               setState(() {
// //rebuilds UI with new QR code
//                 textdata = textcontroller.text;
//               });
//             },
//           ),
//           ElevatedButton(
//             child: Text('Share'),
//             onPressed: () async {
//               try {
//                 RenderRepaintBoundary boundary = key.currentContext!
//                     .findRenderObject() as RenderRepaintBoundary;
// //captures qr image
//                 var image = await boundary.toImage();
//                 ByteData? byteData =
//                 await image.toByteData(format: ImageByteFormat.png);
//                 Uint8List pngBytes = byteData!.buffer.asUint8List();
// //app directory for storing images.
//                 final appDir = await getApplicationDocumentsDirectory();
// //current time
//                 var datetime = DateTime.now();
// //qr image file creation
//                 file = await File('${appDir.path}/$datetime.png').create();
// //appending data
//                 await file?.writeAsBytes(pngBytes);
// //Shares QR image
//                 await Share.shareFiles(
//                   [file!.path],
//                   mimeTypes: ["image/png"],
//                   text: "Share the QR Code",
//                 );
//               } catch (e) {
//                 print(e.toString());
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
