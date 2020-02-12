import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FirebaseConnection {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("Jatek");

  void createRecord(String szo, String jatekid, List beirtSzavak) {
    var jatekId = databaseReference.child(jatekid);
    jatekId
        .set({'adottSzo': szo, 'beirtszavak': beirtSzavak, 'adottJatekos': 0});
    getData();
  }

  void ujJatekLetrehoz(jatekid) async {
    //databaseReference.child(jatekid).set(jatekid);
    //print(await getUserId().toString());
    /*
    databaseReference
        .child("Felhasznalok")
        .set({'uid': await getUserId().toString()});
    print("ujjatekletrehoz");
    */
    String s = currentUser().toString();
    print("UID: $s");
    //getData();
  }

  Future<bool> idLetezikE(String id) async {
    final adat = await databaseReference.child(id).once();
    if (adat.value != null) {
      print("Van id");
      return true;
    } else {
      print("Nincs ilyen id");
      return false;
    }
  }

  Future<String> currentUser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid;
    return user != null ? user.uid : null;
  }

  Future<String> getUserId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid;
    print(uid.length);
    return uid;
  }

  void lepes(List<String> beirtSzavak, String id) {
    databaseReference.child(id).update({'beirtszavak': beirtSzavak});
  }

  Future<String> getSzo(String id) async {
    final adat = await databaseReference.child(id).once();
    if (adat.value != null) {
      print("${adat.value}");
      return adat.value["adottSzo"];
    } else {
      return null;
    }
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }
}
