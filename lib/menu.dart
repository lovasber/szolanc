import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:szolanc/FirebaseConnection.dart';
import 'App.dart';

TextEditingController tfController = new TextEditingController();

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(66, 66, 66, 1),
      appBar: AppBar(
        title: Text(
          "Szólánc",
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 2),
          ),
        ),
        backgroundColor: Color.fromRGBO(253, 216, 53, 5),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Center(
            child: RaisedButton(
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25)),
              child: Text(
                "Új Játék",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                String id = randomString(10);

                navigateToSubPage(
                    context,
                    SzolancApp(
                      gameID: id,
                      title: id,
                      ujGamE: true,
                    ));
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: RaisedButton(
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25)),
              child: Text(
                "Csatlakozás Játékhoz",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                navigateToSubPage(context, Csatlakozas());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Csatlakozas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Csatlakozás",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        onPressed: () async {
          FirebaseConnection fbc = new FirebaseConnection();
          if (await fbc.idLetezikE(tfController.text)) {
            print("Van ilyen id");
            navigateToSubPage(
                context,
                SzolancApp(
                  title: tfController.text,
                  gameID: tfController.text,
                  ujGamE: false,
                ));
          } else {
            print("gáz van");
          }
          //model.firebaseConn.idLetezikE(tfController.text);
        },
      ),
      backgroundColor: Color.fromRGBO(66, 66, 66, 1),
      appBar: AppBar(
        title: Text(
          "Szólánc",
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 2),
          ),
        ),
        backgroundColor: Color.fromRGBO(253, 216, 53, 5),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                "Játék azonosítója:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: tfController,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future navigateToSubPage(context, target) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => target));
}

String _randomString(int strlen) {
  final String chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (int i = 0; i < strlen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result.toUpperCase();
}
