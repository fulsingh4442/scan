import 'package:flutter/material.dart';
import 'package:scan/screen/home.dart';
import 'package:scan/screen/pdf.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home(),
     // home: GenerateScreen(),
    );
  }
}


