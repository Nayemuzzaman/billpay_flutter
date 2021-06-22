import 'package:flutter/material.dart';

class MyComponentsLoader extends StatelessWidget {
  final Color color;

  MyComponentsLoader({required this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
