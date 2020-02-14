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
    //final JATEKID = randomString(10);

    firebaseConn = new FirebaseConnection();
    JATEKOSID = uuid.v1();
    // print("uid: $JATEKID");
  }

  Future<String> readData() async {
    String jolo = await rootBundle.loadString('assets/szavak.txt');
    this.osszesSzo = jolo.split("\n");
    //print(jolo);
    Random rnd = new Random();
    //int length = osszesSzo.length;
    //print("osszes SzoDb: $length"); //mukodik 2000
    //String szo;
    //if (ujGamE) {
//    adottSzo = osszesSzo[rnd.nextInt(osszesSzo.length)];
 //   beirtSzavak.add(adottSzo);
    return osszesSzo[rnd.nextInt(osszesSzo.length)];
    /*} else {
      return await firebaseConn.getSzo(JATEKID);
    }*/
  }
}
