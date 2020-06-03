import 'dart:math';

import 'package:flipper_app/bloc/game/bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlipperWidget extends StatefulWidget {
  final int index;
  final bool stay_flipped_open;
  final bool do_animation;
  final String image;

  const FlipperWidget({Key key, @required this.index, @required this.stay_flipped_open, @required this.do_animation, @required this.image}) : super(key: key);
  @override
  _FlipperWidgetState createState() => _FlipperWidgetState();
}

class _FlipperWidgetState extends State<FlipperWidget>
    with SingleTickerProviderStateMixin {
  bool reversed = false;
  Animation<double> _animation;
  AnimationController _animationController;
  // BlocProvider.of<GameBloc>(context)

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500 ));

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -pi / 2), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: pi / 2, end: 0.0), weight: 0.5)
    ]).animate(_animationController);
  }

  _doAnim() {
    int taps = 0;
    if (!mounted) return;
    if (reversed) {
      _animationController.reverse();
      reversed = false;
    } else {
      _animationController.forward();
      reversed = true;
      print(taps+=1);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.index);
    print(widget.do_animation);
    print(widget.stay_flipped_open);
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation.value),
                child: GestureDetector(
                  onTap: _doAnim,
                  child: IndexedStack(
                    children: <Widget>[CardOne(), CardTwo(image: widget.image,)],
                    alignment: Alignment.center,
                    index: _animationController.value < 0.5 ? 0 : 1,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Container(
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            "Tap to see the code",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  final String image;

  const CardTwo({Key key, @required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Container(
        width: 100,
        height: 100,
        child: Image.network(
          image,
          fit: BoxFit.cover
        ),
      ),
    );
  }
}