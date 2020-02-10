import 'package:firebase_database/firebase_database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConnection{
  final databaseReference = FirebaseDatabase.instance.reference().child("Jatek");
  //var _firebaseRef = FirebaseDatabase().reference().child("Jatek");
 // final databaseReference = Firestore.instance;

   void createRecord(String szo){
     databaseReference.push().set({
       'adottSzo':szo
     });

    getData();
    
  }
  
  void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

}