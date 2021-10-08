import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Model.dart';

class FirebaseConnection {
   //= FirebaseDatabase.instance.reference();
  DatabaseReference databaseReference; //= FirebaseDatabase.instance.reference();



  FirebaseConnection()  {
    setConnection();
  }

  setConnection() async {
    databaseReference =  FirebaseDatabase.instance.reference();
    print("Connection ready");
  }

  //databaseReference.onChildChanged.listen();

  void createRecord(
      String szo, String jatekid, List beirtSzavak, Model model) async {
    ///databaseReference.onChildChanged.listen(onData)

    var jatekId = await databaseReference.child(jatekid).child("Jatek");

    int jatekosDb = await getMaxSorszam(jatekid);
    int index = await getAktivSorszam(jatekid); //Jatek.sorszam
    index++;
    if (index > jatekosDb) {
      index = 1;
    }

    jatekId.set(
        {'adottSzo': szo, 'beirtszavak': beirtSzavak, 'AktivJatekos': index});

    model.osszesBeirtSzoLista = await getbeirtSzavakLista(jatekid);

    //getData();
  }

  void megelevoJatekhozCsatlakoz(String jatekid, Model model) async {
    int sorszam;
    sorszam = await getMaxSorszam(jatekid);
    sorszam++;
    model.JATEKOSSORSZAM = sorszam;

    //print("id: $jatekid");
    databaseReference
        .child(jatekid)
        .child("Felhasznalok")
        .push()
        .set({'uuid': model.JATEKOSID, 'sorszam': sorszam});
    model.osszesBeirtSzoLista = await getbeirtSzavakLista(jatekid);
  }

  Future<String> ujJatekLetrehoz(String jatekid, Model model) async {
    //ujszo
    var szo = await model.readData();
    model.osszesBeirtSzoLista.add(szo);
    print("szo: $szo");
    var jatekId = databaseReference.child(jatekid).child("Jatek");
    jatekId.set({
      'adottSzo': szo,
      'beirtszavak': model.osszesBeirtSzoLista,
      'AktivJatekos': 1,
      'JatekFutE': false
    });

    databaseReference
        .child(jatekid)
        .child("Felhasznalok")
        .push()
        .set({'uuid': model.JATEKOSID, 'sorszam': 1});

    return szo;
  }

  Future<bool> getJatekFutE(String id) async {
    bool jatekFut;
    await databaseReference
        .child(id)
        .child("Jatek")
        .once()
        .then((DataSnapshot snapshot) {
      jatekFut = snapshot.value["JatekFutE"];
    });

    return jatekFut;
  }

  Future<bool> setJatekFutE(String id, bool futE) async {
    bool jatekFut;
    await databaseReference
        .child(id)
        .child("Jatek")
        .once()
        .then((DataSnapshot snapshot) {
      snapshot.value["JatekFutE"] = futE;
    });

    return jatekFut;
  }

  Future<bool> idLetezikE(String id) async {
    final adat = await databaseReference.child(id).child("Jatek").once();
    if (adat.value != null) {
      print("Van id");
      return true;
    } else {
      print("Nincs ilyen id");
      return false;
    }
  }

  Future<String> getUserId() async {
    final User user = (await FirebaseAuth.instance.currentUser);
    final String uid = user.uid;

    return uid;
  }

  void lepes(List<String> beirtSzavak, String id) async {}

  Future<String> getSzo(String id, Model model) async {
    final adat = await databaseReference.child(id).child("Jatek").once();
    if (adat.value != null) {
      // print("${adat.value}");
      return adat.value["adottSzo"];
    } else {
      return null;
    }
  }

  Future<List<String>> getbeirtSzavakLista(String id) async {
    final adat = await databaseReference.child(id).child("Jatek").once();
    if (adat.value != null) {
      //print("${adat.value}");

      return List.from(adat.value["beirtszavak"]);
      //return adat.value["beirtszavak"];
    } else {
      return null;
    }
  }

  void getData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      //print('Data : ${snapshot.value}');
    });
  }

  Future<int> getMaxSorszam(String id) async {
    int sorszam;
    await databaseReference
        .child(id)
        .child("Felhasznalok")
        .once()
        .then((DataSnapshot snapshot) {
      Map beirtSzavak = snapshot.value;
      sorszam = beirtSzavak.length;
    });
    return sorszam;
  }

  Future<int> getAktivSorszam(String id) async {
    int sorszam;
    await databaseReference
        .child(id)
        .child("Jatek")
        .once()
        .then((DataSnapshot snapshot) {
      sorszam = snapshot.value["AktivJatekos"];
    });
    return sorszam;
  }
}
