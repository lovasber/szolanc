import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:szolanc/CountDownTimer.dart';
import 'GameOver.dart';
import 'Model.dart';
import 'Controller.dart';

class SzolancApp extends StatefulWidget {
  final String title;
  String gameID;
  bool ujGamE;
  String szo;
  Model model;

  SzolancApp({this.title = "id", this.gameID, @required this.ujGamE, this.szo,  @required this.model});

  @override
  _SzolancAppState createState() => _SzolancAppState(gameID, ujGamE, szo, this.model);
}

class _SzolancAppState extends State<SzolancApp> {
  Model model;
  Controller controller;
  TextEditingController tfController = new TextEditingController();
  String adottSzo = "";
  bool ujGamE;
  bool futE;

  _SzolancAppState(String gameID, bool ujgamE, String szo, Model model) {
    this.model = model;
    this.controller = new Controller(this.model);
    this. ujGamE = ujGamE;
    this.futE = true;

    this.model.firebaseConn.databaseReference
        .child(gameID)
        .child("Jatek")
        .child("beirtszavak")
        .onChildAdded
        .listen((data) {
      // print("data: ${data.snapshot.value}");

          setState(() {
            //model.beirtSzavak = da
            this.model.adottSzo = data.snapshot.value;
            adottSzo = data.snapshot.value;
            betolt(gameID);
          });
        });

      if (ujgamE) {
        this.model.firebaseConn.ujJatekLetrehoz(gameID, this.model, true);
      } else {
        betolt(gameID);
        controller.model.firebaseConn.megelevoJatekhozCsatlakoz(gameID, this.model);
      }
  }

  void betolt(String gameID) async {
    model.osszesBeirtSzoLista =
        await model.firebaseConn.getbeirtSzavakLista(gameID);

    model.beirtSzavakS = model.osszesBeirtSzoLista.toString();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    this.model.firebaseConn.databaseReference.child(this.model.JATEKID).onValue.listen((event){
      var snapshot = event.snapshot;
      bool value = snapshot.value['Jatek']['JatekFutE'];
      this.futE = value;
      //this.model.futE = value;
      if(this.futE != true) {
        //print("changed - ${value}");
        refresh();
      }
    });

    return this.futE ? Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text("OK"),
        onPressed: () async {
          //setState(() {
          //CountDownTimerState().startTimer();
          //});

          //if(this.controller.model.firebaseConn.getAktivSorszam()==model.jatekosId){
          //widget.ujGame = true;
          //}else{
          widget.ujGamE = this.ujGamE;
          //}
         // CountDownTimer().setTimer(10);
          if (this.controller.beirtSzoEllenoriz(tfController.text, adottSzo)) {
            String beirt = tfController.text;

            //ITT INDULT RÉGEN A JÁTÉK

            model.firebaseConn.createRecord(tfController.text, model.JATEKID,
                model.osszesBeirtSzoLista, model);
            tfController.text = "";
            // CountDownTimerState().startTimer(); //Nullázza az időzítőt
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
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      child: Text(
                          "Vége"
                      ),
                      onPressed: ()=>{
                        vegeOnPressed(context)
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                    )
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                //Expanded(
                 // child: CountDownTimer(),
                //)

                //Text("na")
              ],
              /*
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text("${controller.current}"), //TODO
                )
              ],*/
            ),
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
                        "${snapshot.data}".toUpperCase(),
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
            Center(
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Eddigi lánc:",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 500.0,
                    child: new ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: model.osszesBeirtSzoLista.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new Text(
                          //LISTA Minden szó
                          model.osszesBeirtSzoLista[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),

              ],
            )

            /*
          Marquee(
            text:
            "${model.beirtSzavak}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                ),
              ),
    */
          ],
        ),
      ),
    )
    :
    GameOver(model: this.model);
  }

  vegeOnPressed(BuildContext context) {
    this.model.firebaseConn.setJatekFutE(this.model.JATEKID, false);
    navigateToSubPage(context, GameOver(model:this.model));
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
