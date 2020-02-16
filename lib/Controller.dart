import 'Model.dart';

//TODO : sz,cs,gy bugokat fixelni
//TODO : Időre menjen
//TODO : Ne csatlakoztasson le amikor visszalépsz a főmenübe
//TODO : Megrázni a usert ha rossz szót ír be
//TODO : Még több szó
//TODO : valamin keresztül meghívni a másikat

class Controller {
  Model model;
  var app;

  Controller(Model model) {
    //this.firebase = new  FirebaseUser();
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

        model.beirtSzavak.add(beirt);

        joSzo = true;
      } else {
        print("nem uj szó!");
      }
    } else {
      print("nem lánc");
    }
    /*} else {
      print("nem létezik");
    }*/

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
    if (!model.beirtSzavak.contains(beirt.toLowerCase())) {
      letezik = true;
    }
    return letezik;
  }
}
