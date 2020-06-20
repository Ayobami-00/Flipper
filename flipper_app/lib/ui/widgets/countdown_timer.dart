import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  State createState() => new _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> with TickerProviderStateMixin{
  Timer _timer;
  int _start = 10;
  AnimationController motionController;
   Animation motionAnimation;
   double size = 20;

   void initState() {
     super.initState();
 
     motionController = AnimationController(
       duration: Duration(seconds: 1),
       vsync: this,
       lowerBound: 0.5,
     );
 
     motionAnimation = CurvedAnimation(
       parent: motionController,
       curve: Curves.ease,
     );
 
     motionController.forward();
     motionController.addStatusListener((status) {
       setState(() {
         if (status == AnimationStatus.completed) {
           motionController.reverse();
         } else if (status == AnimationStatus.dismissed) {
           motionController.forward();
         }
       });
     });
 
     motionController.addListener(() {
       setState(() {
         size = motionController.value * 250;
       });
     });
     // motionController.repeat();

     startTimer();
   }
  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) => setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }
  }



  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green,
      // appBar: AppBar(title: Text("Timer test")),
      body: Center(
        child:Container(
          height: size,
          child: Text("$_start",
                style: TextStyle(color: Colors.white, fontSize: 130.0)
          ))
          
      )
    );
  }
}





