import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:szolanc/WaitingForPlayers.dart';

import 'App.dart';
import 'Model.dart';
import 'menu.dart';



class QrScanner extends StatelessWidget {
  String qrCodeValue;
  Model model;

  QrScanner(Model model){
    this.model = model;
  }


  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }

  Widget _buildCard(BuildContext context) => new Container(
    child: new Center(
      child: new Container(
        color: Colors.lightBlue,
        child: new Center(
          child: new
          Scaffold(
            body:
                Column(
                  children: [
                    Row(
                      children: [
                        Center(
                          child: ElevatedButton(
                              onPressed: () => {
                                scanQrCode(context)
                              },
                              child: Text("Start barcode scan")),
                        ),
                      ]
                    )
                  ],
                ),
          ),
        ),
      ),
    ),
  );


  Future<void> scanQrCode(context) async{
    String qrValue = "";

    try {
      qrValue = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Mégse", false, ScanMode.QR);
      navigateToSubPage(context, WaitingForPlayers(
          id: qrValue,
          model: this.model,
      ));
    } on PlatformException {
      qrValue = 'Failed to get platform version.';
    }

  }

  Future navigateToSubPage(context, target) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => target));
  }

}