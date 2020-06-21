import 'package:flipper_app/bloc/game/bloc/game_bloc.dart';
import 'package:flipper_app/models/card_data.dart';
import 'package:flipper_app/ui/widgets/loading.dart';
import 'package:flipper_app/ui/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flipper_app/ui/widgets/flipper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameRoom extends StatefulWidget {
  @override
  _GameRoomState createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoom> {

  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('USERNAME');
    return stringValue;
  }

  // Box<CardData> cardsDataBox;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<GameBloc>(context).add(LoadGamePage());
  }

  @override
  void initState() {
    // _intializeBox();
    super.initState();
   
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  // Future _intializeBox() async {
  //   await Hive.openBox('cardsData');
  //   //  cardsDataBox = Hive.box<CardData>('cardsData');
  // }

  @override
  Widget build(BuildContext context) {
    int tap_number = 0;

    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    return BlocListener<GameBloc, GameState>(
        listener: (BuildContext context, GameState state) {
      if (state is GamePageLoaded) {
        if (!state.init) {
          if (state.status) {
            Fluttertoast.showToast(
                msg: "Great one!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Ouch! Try again!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      }
    }, child: BlocBuilder<GameBloc, GameState>(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        // set up the buttons
                        Widget cancelButton = FlatButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        Widget continueButton = FlatButton(
                          child: Text("Yes"),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("AlertDialog"),
                          content: Text(
                              "Are you really sure you want to leave the game?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      iconSize: 16.0,
                    ),
                    Container(
                      width: 100.0,
                      padding: EdgeInsets.only(top: 10.0, right: 4.0),
                      child: TimerWidget(
                        secondsRemaining: 59,
                        whenTimeExpires: () {
                          // set up the buttons
                        Widget continueButton = FlatButton(
                          child: Text("Check out high scores!"),
                          onPressed: () {
                            print("Check out high scores!");
                          },
                        );
                        Widget cancelButton = FlatButton(
                          child: Text("Go back to homepage"),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("AlertDialog"),
                          content: Text(
                              "Oops your time has run out! Your score was ${state.score}!"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                        },
                        countDownTimerStyle: TextStyle(
                            color: Colors.black, fontSize: 25.0, height: 1.2),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: appHeight / 20),
              Expanded(
                flex: 10,
                child: Container(
                    child: ValueListenableBuilder(
                  valueListenable: Hive.box('cardsData').listenable(),
                  builder: (context, Box<dynamic> box, _) {
                    if (box.values.isEmpty) {
                      return Text('data is empty');
                    } else {
                      return GridView.builder(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          itemCount: box.values.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 30.0,
                                  crossAxisSpacing: 10.0),
                          itemBuilder: (BuildContext context, int index) {
                            CardData cardData = box.getAt(index);
                            return Container(
                              child: FlipperWidget(
                                index: cardData.index,
                                stay_flipped_open: cardData.stay_flipped_open,
                                do_animation: cardData.do_animation,
                                image: cardData.image,
                              ),
                            );
                            ;
                          });
                    }
                  },
                )),
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
                          child: Center(child: Text(state.score.toString()))),
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
    }));
  }
}
