import 'dart:async' show Future;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math' show Random;
import 'FirebaseConnection.dart';
import 'package:uuid/uuid.dart';

class Model {
  List<String> osszesSzo;
  List<String> beirtSzavak;
  FirebaseConnection firebaseConn;
  String JATEKID;
  String JATEKOSID;
  String beirtSzavakS = "";
  int JATEKOSSORSZAM;
  String adottSzo;

  Model(String jatekId) {
    var uuid = Uuid();
    beirtSzavak = List<String>();
    JATEKID = jatekId;
    firebaseConn = new FirebaseConnection();
    JATEKOSID = uuid.v1();
  }

  Future<String> readData() async {
    String jolo = await rootBundle.loadString('assets/szavak.txt');
    this.osszesSzo = jolo.split("\n");
    Random rnd = new Random();
    return osszesSzo[rnd.nextInt(osszesSzo.length)];
  }
}
