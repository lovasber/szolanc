import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Model.dart';
import 'App.dart';

  class WaitingForPlayers extends StatefulWidget {
    String id;
    List<String> usernames;
    bool isNewGame; //ahol meghívtam ott nem írtam második parmétert
    Model model;

    WaitingForPlayers({this.id, this.model, this.isNewGame});

    @override
    HomeState createState() {
      return new HomeState(id : id, usernames : usernames, isNewGame : this.isNewGame, model: this.model);
    }
  }

  class HomeState extends State<WaitingForPlayers> {
    bool _hasCard;
    String id;
    bool isNewGame;
    List<String> usernames;
    Model model;

    HomeState({this.id, this.usernames, this.isNewGame, this.model});

    @override
    void initState() {
      super.initState();
      _hasCard = false;
      //CREATE GAME IN DB!
    }

    @override
    Widget build(BuildContext context) {
      List<Widget> children = new List();
      //Kell egy modell!!!
      //FirebaseDatabase({, String databaseURL});

      children.add(_buildBackground());
      if (_hasCard) children.add(_buildCard());

      return Scaffold(
        backgroundColor: Color.fromRGBO(66, 66, 66, 1),
        appBar: AppBar(
          title: Text(
            this.id,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 2),
            ),
          ),
          backgroundColor: Color.fromRGBO(253, 216, 53, 5),
        ),
        body: _buildCard(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Játék indítása"),
          onPressed: () =>  {
              jatekInditasaPressed(context, id)
          },
        ),
      );
    }

    void _showCard() {
      setState(() => _hasCard = true);
    }

    void _hideCard() {
      setState(() => _hasCard = false);
    }

    Widget _buildCard() => new Container(
      child: new Center(
        child: new Container(
          height: 200.0,
          width: 200.0,
          color: Colors.lightBlue,
          child: new Center(
            child: new
            Scaffold(
            body:
              Center(
                child: QrImage(
                  data: this.id,//Game Id
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Future navigateToSubPage(context, target) async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => target));
    }

    Widget _buildBackground() => new Scaffold(
      body: new Container(
        child: _hasCard
            ? new TextButton(
            onPressed: _hideCard, child: new Text("X"))
            : new TextButton(
            onPressed: _showCard, child: new Text("Qr kód")),
      ),
    );

  jatekInditasaPressed(BuildContext context, String id){
    this.model.firebaseConn.setJatekFutE( id, true);
    navigateToSubPage(context,
        SzolancApp(
            gameID: id,
            title: id,
            ujGamE: true,
            model: this.model,
        )
    );
  }


  }