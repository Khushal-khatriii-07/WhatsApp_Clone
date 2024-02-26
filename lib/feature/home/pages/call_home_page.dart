import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('call Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add_ic_call_sharp),
      ),
    );
  }
}