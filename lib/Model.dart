import 'dart:async' show Future;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math' show Random;
import 'FirebaseConnection.dart';

class Model {
  List<String> osszesSzo;
  List<String> beirtSzavak;
  FirebaseConnection firebaseConn;
  String JATEKID;
  String JATEKOSID = "beirtId";
  String beirtSzavakS = "";

  Model(String jatekId) {
    beirtSzavak = List<String>();
    JATEKID = jatekId;
    //final JATEKID = randomString(10);
    firebaseConn = new FirebaseConnection();
    //JATEKOSID = firebaseConn.getUserId().toString();
    // print("uid: $JATEKID");
  }

  Future<String> readData() async {
    String jolo = await rootBundle.loadString('assets/szavak.txt');
    this.osszesSzo = jolo.split("\n");
    //print(jolo);
    Random rnd = new Random();
    //int length = osszesSzo.length;
    //print("osszes SzoDb: $length"); //mukodik 2000
    return osszesSzo[rnd.nextInt(osszesSzo.length)];
  }
}
