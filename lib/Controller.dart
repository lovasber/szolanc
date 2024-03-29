import 'dart:async';
import 'package:flutter/material.dart';
import 'Model.dart';
import 'package:quiver/async.dart';

//TODO : sz,cs,gy bugokat fixelni
//TODO : Ne csatlakoztasson le amikor visszalépsz a főmenübe
//TODO : Megrázni a usert ha rossz szót ír be
//TODO : Még több szó
//TODO : valamin keresztül meghívni a másikat - qr kód
//TODO : Usereket törölni ha nem aktívak
//TODO : Userenként elmenteni a listákat

class Controller {
  Model model;
  var app;
  Timer timer;
  int start = 10;
  int current = 10;

  Controller(Model model) {
    app = this.model = model;
  }

  bool beirtSzoEllenoriz(String beirt, String adott) {
    bool joSzo = false;
    //if (letezoSzoE(beirt, model)) {
    print("letező szó!");
    if (lancE(beirt, adott)) {
      print("lanc!");
      if (ujSzoE(beirt, model)) {
        print("ujszó");

        model.osszesBeirtSzoLista.add(beirt);

        joSzo = true;
      } else {
        print("nem uj szó!");
      }
    } else {
      print("nem lánc");
    }
    return joSzo;
  }

  bool letezoSzoE(String beirt, Model model) {
    bool letezik = false;
    if (model.osszesSzo.contains(beirt.toLowerCase())) {
      letezik = true;
    }
    return letezik;
  }

  bool lancE(String beirt, String adott) {
    bool lanc = false;
    String beirttElso = beirt.substring(0, 1);
    String adottUtolso = adott.substring(adott.length - 1, adott.length);

    if (beirttElso == adottUtolso) {
      lanc = true;
    }

    return lanc;
  }

  bool ujSzoE(String beirt, Model model) {
    bool letezik = false;
    if (!model.osszesBeirtSzoLista.contains(beirt.toLowerCase())) {
      letezik = true;
    }
    return letezik;
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      //setState(() {
      current = start - duration.elapsed.inSeconds;
      //});
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  Future navigateToSubPage(context, target) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => target));
  }
}
