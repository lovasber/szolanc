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

    bool idVanE(String id){
      databaseReference.orderByChild(id).equalTo(id).once().then((snapshot){
        databaseReference.reference();
        if(snapshot!=null){
          print("nincs ilyen");
          return false;
        }else{
          print("Van id");
          return true;
        }

      });
    }
      
  void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

}