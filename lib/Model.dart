import 'dart:async' show Future;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math' show Random;
import 'FirebaseConnection.dart';
import 'package:uuid/uuid.dart';

class Model {
  List<String> osszesSzo;
  List<String> osszesBeirtSzoLista;
  List<String> sajatBeirtSzavak;
  FirebaseConnection firebaseConn;
  String JATEKID;
  String JATEKOSID;
  String beirtSzavakS = "";
  int JATEKOSSORSZAM;
  String adottSzo;
  String jatekosNev;
  bool futE;

  Model(String jatekId)  {
    var uuid = Uuid();
    osszesBeirtSzoLista = []; //List<String>();
    JATEKID = jatekId;
    setConnection();
    JATEKOSID = uuid.v1();
    this.futE = false;
  }

  setConnection() async {
    this.firebaseConn = await new FirebaseConnection();
  }

  setJAtekID(String jatekId){
    this.JATEKID = jatekId;
  }

  Future<String> readData() async {
    String szavak = await rootBundle.loadString('assets/szavak.txt');
    this.osszesSzo =  szavak.split("\n");
    Random rnd = new Random();
    return osszesSzo[rnd.nextInt(osszesSzo.length)];
  }


}
