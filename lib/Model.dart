import 'dart:async' show Future;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math' show Random;

class Model {
  List<String> osszesSzo;
  List<String> beirtSzavak;
  static const String JATEKID = "aa";
  String beirtSzavakS = "";

  final String chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  Model() {
    beirtSzavak = List<String>();
    final String sss = randomString(10);
    //this.JATEKID = sss;
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

  String randomString(int strlen) {
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (int i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result.toUpperCase();
  }
}
