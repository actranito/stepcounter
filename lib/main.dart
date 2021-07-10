import 'package:flutter/material.dart';
import 'package:stepcounter/views/test_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stepcounter',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.blue,
      ),
      home: TestView(),
    );
  }
}
