import 'dart:async';
import 'package:flutter/cupertino.dart';
//import 'dart:math'show pi;
import 'package:flutter/material.dart';
import 'package:szolanc/GameOver.dart';

Timer timer;
int start = 10;

class CountDownTimer extends StatefulWidget {
  @override
  CountDownTimerState createState() => CountDownTimerState();
  void setTimer(int ido) {
    start = ido;
  }
}

class CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "$start",
      style: TextStyle(
        fontSize: 25,
        color: Colors.pink,
      ),
    ));
  }

  void startTimer() {
    start = 30;
    const oneSec = const Duration(seconds: 1);
    try {
      timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(
          () {
            if (start < 1) {
              timer.cancel();

              //navigateToSubPage(context, GameOver());
            } else {
              start = start - 1;
            }
          },
        ),
      );
    } catch (Exception) {
      print("Hiba a számoláskor");
    }
  }
}

Future navigateToSubPage(context, target) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => target));
}
