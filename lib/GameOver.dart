import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:szolanc/App.dart';
import 'package:szolanc/menu.dart';

//Ugyanazzal a csapattal új játék
//csak kiírja a nyerteseket

class GameOver extends StatelessWidget{
  String jatekId;
  String gyoztes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Color.fromRGBO(66, 66, 66, 1),
        appBar: AppBar(
        title: Text("Game over",
            style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 2),
            ),
          ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(253, 216, 53, 5),
        ),
                
        body:
        Column(
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
           Center(
          child: RaisedButton(
            color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25)),
            child: Text(
              "Újra"
            ),
           onPressed: ()=>{
             navigateToSubPage(context, new Menu())
             },
          ),

          ),
          ],
        )   
      ),      
    ); 
  }

}

Future navigateToSubPage(context, target) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => target));
}

