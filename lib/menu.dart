import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:szolanc/FirebaseConnection.dart';
import 'App.dart';
import 'Model.dart';
import 'QrScanner.dart';
import 'WaitingForPlayers.dart';

TextEditingController tfController = new TextEditingController();

class Menu extends StatelessWidget {
  String gameID;
  Model model;

  Menu(){
    setModel();
  }


  setModel() async {
    this.gameID = await randomString(10);
    this.model = await new Model(gameID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(66, 66, 66, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              onPressed: () async {
                ujJatekPressed(context);
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
                navigateToSubPage(context, Csatlakozas(model: model));
              },
            ),
          ),
          Center(
            child: RaisedButton(
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25)),
              child: Text(
                "QRcode test",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              onPressed: () {
                navigateToSubPage(context, WaitingForPlayers());
              },
            ),
          ),
        ],
      ),
    );
  }

  void ujJatekPressed(BuildContext context) async{
    print("ujjatekpressed");

    await this.model.firebaseConn.ujJatekLetrehoz(this.gameID, this.model);

    navigateToSubPage(
        context,
        /*
        SzolancApp(
                      gameID: id,
                      title: id,
                      ujGamE: true,
                    )
        */
        WaitingForPlayers(id: this.gameID, model: this.model)
    );
  }
}

class Csatlakozas extends StatelessWidget {
  Model model;

  Csatlakozas({this.model});

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
        onPressed:() {
          meglevoJatekhozCsatlakoz(context);
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
        child:
            Column(
              children: [
                Row(
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
                Row(
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: Text(
                            "Qr kód leolvasása"
                        ),
                        onPressed: () { 
                          navigateToSubPage(context, QrScanner(this.model));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),

    );
  }

  meglevoJatekhozCsatlakoz(BuildContext context) async{
      FirebaseConnection fbc = new FirebaseConnection(); ///!!!!!!!!
      if (await fbc.idLetezikE(tfController.text)) {
        String jatekId = tfController.text;
        this.model.setJAtekID(jatekId);
        //print("Van ilyen id");
        navigateToSubPage(
            context,
            //Itt a váróba rakja be őt is
            /*
            SzolancApp(
              title: tfController.text,
              gameID: tfController.text,
              ujGamE: false,
            ));
            */

            WaitingForPlayers(id: jatekId, model: this.model, isNewGame: false));
      } else {
        //print("Nincs ilyen id");
      }
      //model.firebaseConn.idLetezikE(tfController.text);
    }

}


Future<void> scanQrCode() async{
  String qrValue = "";

  try {
    qrValue = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Mégse", false, ScanMode.QR);
  } on PlatformException {
    qrValue = 'Failed to get platform version.';
  }

  return qrValue;
}

class QrCodeReader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text("");//FLOAT
  }

}

Future<void> navigateToSubPage(context, target) async {
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
