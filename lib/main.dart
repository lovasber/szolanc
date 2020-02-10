//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Model.dart';
import 'Controller.dart';

Model model = new Model();
Controller controller = new Controller(model);
TextEditingController tfController = new TextEditingController();
String adottSzo = "";

void main() => runApp(
      MaterialApp(
        home: new Menu(),
      ),
    );

class SzolancApp extends StatefulWidget {
  final String title;

  SzolancApp({/*@required*/ this.title = "asdf"});

  @override
  _SzolancAppState createState() => _SzolancAppState();
}

class _SzolancAppState extends State<SzolancApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text("OK"),
        onPressed: () {
          if (controller.beirtSzoEllenoriz(tfController.text, adottSzo)) {
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
                future: model.readData(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = <Widget>[
                      Text(
                        "${adottSzo = snapshot.data}".toUpperCase(),
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
                    controller: tfController,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 5),
                      fontSize: 23,
                    ),
                    decoration: InputDecoration(
                      hintText: "Tipp",
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
                navigateToSubPage(context, SzolancApp());
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
        onPressed: () {},
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
/*
class AbUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("...");
            } else {
              return Text("${snapshot.data.documents[0]}");
            }
          }),
    );
  }
}
*/
