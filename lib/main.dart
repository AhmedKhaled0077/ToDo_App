import 'package:flutter/material.dart';
import 'package:full_app2/layout/Todo_homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: TodoHomescreen(),
    );
  }
}
