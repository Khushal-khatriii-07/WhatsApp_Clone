import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Updates Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_alt_rounded),
      ),
    );
  }
}
