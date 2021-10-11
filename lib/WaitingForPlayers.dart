import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Model.dart';
import 'App.dart';


/// KEll figyelni hogy valamelyik user megnyomja e a játék indítását ✅


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

  class HomeState extends State<StatefulWidget> {
    bool _hasCard;
    String id;
    bool isNewGame;
    List<String> usernames;
    Model model;
    bool futE = false;


    HomeState({this.id, this.usernames, this.isNewGame, this.model});

    @override
    void initState() {
      super.initState();
      _hasCard = false;
      //CREATE GAME IN DB!
    }

    refresh() {
      setState(() {});
    }

    @override
    Widget build(BuildContext context) {
      List<Widget> children = [];

      this.model.firebaseConn.databaseReference.child(this.id).onValue.listen((event){
        var snapshot = event.snapshot;
        bool value = snapshot.value['Jatek']['JatekFutE'];
        this.futE = value;
        //this.model.futE = value;
        if(this.futE == true) {
          //print("changed - ${value}");
          refresh();
        }
      });

      children.add(_buildBackground());
      if (_hasCard) children.add(_buildCard());

      //print("statefulE  - ${this.futE}");

      return this.futE ?
      SzolancApp(ujGamE: false, model: this.model, gameID: this.model.JATEKID,szo: this.model.adottSzo, title: this.model.JATEKID)
      :
      Scaffold(

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
    this.model.futE = true;
    navigateToSubPage(context,
        SzolancApp(
            gameID: id,
            title: id,
            ujGamE: this.isNewGame,
            model: this.model,

        )
    );
  }


  }