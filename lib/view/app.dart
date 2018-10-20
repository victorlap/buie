import 'package:buie/view/main.dart';
import 'package:flutter/material.dart';

class BuieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Buie',
      home: new MainScreen(),
    );
  }
}
