import 'package:flipper_app/bloc/game/bloc/game_bloc.dart';
import 'package:flipper_app/ui/widgets/loading.dart';
import 'package:flipper_app/ui/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flipper_app/ui/widgets/flipper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GameRoom extends StatefulWidget {
  @override
  _GameRoomState createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<GameBloc>(context).add(LoadGamePage());
  }

  @override
  void initState() {
    _intializeBox();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Future _intializeBox() async {
    await Hive.openBox('gameRoomData');
  }

  @override
  Widget build(BuildContext context) {
    int tap_number = 0;

    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<GameBloc, GameState>(
        builder: (BuildContext context, GameState state) {
      List<Map<String, dynamic>> test_list = [];
      if (state is GamePageLoaded) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    child: Container(
                  width: 100.0,
                  padding: EdgeInsets.only(top: 10.0, right: 4.0),
                  child: CountDownTimer(
                    secondsRemaining: 59,
                    whenTimeExpires: () {
                      setState(() {
                        // hasTimerStopped = true;
                      });
                    },
                    countDownTimerStyle: TextStyle(
                        color: Colors.black, fontSize: 25.0, height: 1.2),
                  ),
                )),
              ),
              SizedBox(height: appHeight / 20),
              Expanded(
                flex: 10,
                child: Container(
                    child: GridView.builder(
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        itemCount: 12,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 30.0,
                            crossAxisSpacing: 10.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: FlipperWidget(
                              index: index,
                              stay_flipped_open:
                                  state.cards_data[index.toString()]
                                      ["stay_flipped_open"],
                              do_animation: state.cards_data[index.toString()]
                                  ["do_animation"],
                              image: state.cards_data[index.toString()]
                                  ["image"],
                            ),
                          );
                        })),
              ),
              SizedBox(height: appHeight / 20),
            ],
          )),
          bottomNavigationBar: BottomAppBar(
              child: Container(
            color: Colors.green[300],
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5.0),
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(child: Text('4'))),
                      Text("Flips Left",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("FESTUS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                              child: Text(state.score.toString())
                              )),
                      Text("Score",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      } else if (state is GameInitial) {
        return Loading();
      } else {
        return Loading();
      }
    });
  }
}

