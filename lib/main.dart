//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'Model.dart';
//import 'Controller.dart';
import 'menu.dart';


void main() => runApp(
      MaterialApp(
        home: new Menu(),
      ),
    );

/*
class AbUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("...");
            } else {
              return Text("${snapshot.data.documents[0]}");
            }
          }),
    );
  }
}
*/
