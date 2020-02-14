import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:szolanc/FirebaseConnection.dart';
import 'Model.dart';
import 'Controller.dart';
import 'menu.dart';
import 'main.dart';

//Hnap folyt köv!

class SzolancApp extends StatefulWidget {
  final String title;
  String gameID;
  bool ujGamE;
  String szo;

  SzolancApp({this.title = "id", this.gameID, @required this.ujGamE, this.szo});

  @override
  _SzolancAppState createState() => _SzolancAppState(gameID, ujGamE, szo);
}

class _SzolancAppState extends State<SzolancApp> {
  static Model model;
  Controller controller;
  TextEditingController tfController = new TextEditingController();
  String adottSzo = "";

  _SzolancAppState(String gameID, bool ujgamE, String szo) {
    //print(" gameId: $gameID");
    model = new Model(gameID);
    print("minden ok");

    controller = new Controller(model);

    model.firebaseConn.databaseReference
        .child(gameID)
        .child("Jatek")
        .child("beirtszavak")
        .onChildAdded
        .listen((data) {
      print("data: ${data.snapshot.value}");

      setState(() {
        model.adottSzo = data.snapshot.value;
        adottSzo = data.snapshot.value;
      });
    });

    if (ujgamE) {
      model.firebaseConn.ujJatekLetrehoz(gameID, model);
      //random szót írjon ki
      //adottSzo =  model.readData() as String;
    } else {
      controller.model.firebaseConn.megelevoJatekhozCsatlakoz(gameID, model);
      //az ab-ból kérje el a szót
      //adottSzo = szo;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text("OK"),
        onPressed: () async {
          //if(this.controller.model.firebaseConn.getAktivSorszam()==model.jatekosId){
          //widget.ujGame = true;
          //}else{
          widget.ujGamE = false;
          //}
          if (this.controller.beirtSzoEllenoriz(tfController.text, adottSzo)) {
            String beirt = tfController.text;
            model.firebaseConn.createRecord(
                tfController.text, model.JATEKID, model.beirtSzavak);
            tfController.text = "";

            this.setState(() {});
          }
        },
      ),
      backgroundColor: Color.fromRGBO(66, 66, 66, 1),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 2),
          ),
        ),
        backgroundColor: Color.fromRGBO(253, 216, 53, 5),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            FutureBuilder(
                future: model.firebaseConn.getSzo(model.JATEKID, model),
                //model.readData(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Text(
                        "${snapshot.data}" //"${model.adottSzo = snapshot.data}" //itt kell majd megnézni hogy elsp kör-e, ha nem akkor kiírni a lista utolsó szavát
                            .toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ];
                  } else {
                    children = <Widget>[Text("...")];
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  );
                }),
            SizedBox(height: 25.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "Ide írj:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    controller: this.tfController,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 5),
                      fontSize: 23,
                    ),
                    decoration: InputDecoration(
                        //hintText: "Tipp",
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Text(
              "${model.beirtSzavakS}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future navigateToSubPage(context, target) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => target));
}

String randomString(int strlen) {
  final String chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (int i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result.toUpperCase();
}
