import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flipper_app/ui/widgets/timer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flipper_app/ui/pages/game.dart';

class CountDownTimerPage extends StatefulWidget {
  State createState() => new _CountDownTimerPageState();
}

class _CountDownTimerPageState extends State<CountDownTimerPage>
    with TickerProviderStateMixin {
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
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.green,
        // appBar: AppBar(title: Text("Timer test")),
        body: Center(
            child: Container(
          height: size,
          child: TimerWidget(
            secondsRemaining: 10,
            whenTimeExpires: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                      child: GameRoom()));
            },
            countDownTimerStyle:
                TextStyle(color: Colors.white, fontSize: 120.0, height: 1.2),
          ),
        )));
  }
}
