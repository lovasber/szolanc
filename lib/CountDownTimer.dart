import 'dart:async';
import 'package:flutter/cupertino.dart';
//import 'dart:math'show pi;
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {

  @override
  CountDownTimerState createState() => CountDownTimerState();

}

class CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
      AnimationController controller;
    Timer timer;
    int start = 10;

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
      child:Text(
      "$start",
      style: TextStyle(
        fontSize: 25,
        color: Colors.pink,
        
      ),
      )
    );
  }

 void startTimer() {
  const oneSec = const Duration(seconds: 1);
  timer = new Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      () {
        if (start < 1) {
          timer.cancel();
          start = 10;
          startTimer();
        } else {
          start = start - 1;
        }
      },
    ),
  );
}
}

