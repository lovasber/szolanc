import 'Model.dart';

//TODO : sz,cs,gy bugokat fixelni
//TODO : Időre menjen
//TODO : firebase
//TODO : Ne csatlakoztasson le amikor visszalépsz a főmenübe
//TODO : Nem lehet ugyanaz a szó mint a kijelzőn
//TODO : Megrázni a usert ha rossz szót ír be
//TODO : Még több szó

class Controller {
  Model model;
  //FirebaseUser app;
  var app;

  Controller(Model model) {
    //this.firebase = new  FirebaseUser();
    app = this.model = model;
  }

  bool beirtSzoEllenoriz(String beirt, String adott) {
    bool joSzo = false;
    if (letezoSzoE(beirt, model)) {
      print("letező szó!");
      if (lancE(beirt, adott)) {
        print("lanc!");
        if (ujSzoE(beirt, model)) {
          print("ujszó");
          model.beirtSzavak.add(adott);
          model.beirtSzavak.add(beirt);
          model.beirtSzavakS = model.beirtSzavak.toString();
          joSzo = true;
        } else {
          print("nem uj szó!");
        }
      } else {
        print("nem lánc");
      }
    } else {
      print("nem létezik");
    }

    return joSzo;
  }
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

//Uj jatek létrehoz
void ujJatekLetrehoz() {
  //Uj objektum letrehoz
  //Beleírni a jatekIdt
  //SzavakListája
}

//Jatek törlése
void jatekTorol() {}

//jatekhoz csatlakozas
void jatekhozCsatlakoz() {}
