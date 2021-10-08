//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'Model.dart';
//import 'Controller.dart';
import 'menu.dart';


/*
void main() => runApp(
      MaterialApp(
        home: new Menu(),
      ),
    );
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
    home: new Menu(),
    ),
  );
}
