import 'package:firebase_database/firebase_database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConnection{
  final databaseReference = FirebaseDatabase.instance.reference().child("Jatek");

   void createRecord(String szo,String jatekid){
      var jatekId = databaseReference.child(jatekid);
      jatekId.set({
        'adottSzo':szo
      });
      getData();
    }

    Future<bool> idLetezikE(String id)async{
        final adat = await databaseReference.child(id).once();
        if(adat.value != null){
          print("Van ilyen id");
          return true;
        }else{
          print("Nincs ilyen id");
          return false;
        }
    }

    Future<String> getSzo(String id)async{
        final adat = await databaseReference.child(id).once();
        if(adat.value != null){
          print("${adat.value}");
          return adat.value["adottSzo"];
        }else{
          return null;
        }
    }
      
  void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

}