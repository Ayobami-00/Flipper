import 'package:flipper_app/ui/widgets/countdown_timer.dart';
import 'package:flipper_app/ui/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flipper_app/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Image backgroundImage;
  TextEditingController _namecontroller = TextEditingController();
  String username;
  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('USERNAME');
    return stringValue;
  }

  @override
  void initState() {
    super.initState();
    //TODO: Fix the issue of delay in loading image
    backgroundImage = Image.asset("assets/images/cube-3324923.jpg");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(backgroundImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            bottom: 0.0,
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: backgroundImage.image,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.darken)),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: Sizes.s50),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: Sizes.spacingAllSmall,
                            child: InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      child: Container(
                                        height: Sizes.s120,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: _namecontroller,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Change your nick name'),
                                              ),
                                              SizedBox(
                                                width: 320.0,
                                                child: RaisedButton(
                                                  onPressed: () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    await prefs.setString(
                                                        'USERNAME',
                                                        _namecontroller.text
                                                            .toUpperCase());
                                                            setState(() {
                                                              username = _namecontroller.text.toUpperCase();
                                                            });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              child: FutureBuilder<String>(
                                future: getStringValuesSF(),
                                initialData: 'GUEST',
                                builder: (context, snapshot) {
                                  username = snapshot.data;
                                  return snapshot.hasData
                                      ? Text(
                                          "$username",
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text("GUEST", 
                                      style: TextStyle(
                                            color: Colors.white,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                      );
                                },
                              ),
                              // Text("ARIANA",
                              //     style: TextStyle(
                              //         color: Colors.white,
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: FontSize.s30)),
                            ),
                          )),
                      SizedBox(height: Sizes.s100),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: Sizes.spacingAllSmall * 3,
                          child: InkWell(
                            onTap: (){
                                Navigator.push(context, PageTransition(type: PageTransitionType.fade ,duration: const Duration(milliseconds: 500), child: CountDownTimer()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Sizes.circularImageRadius / 1.5),
                                  color: Colors.green),
                              child: Center(
                                  child: Text("NEW GAME",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSize.s36))),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: Sizes.spacingAllSmall * 3,
                          child: InkWell(
                            onTap: () => print("Tapped"),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Sizes.circularImageRadius / 1.5),
                                  color: Colors.green),
                              child: Center(
                                  child: Text("HIGH SCORES",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: FontSize.s36))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Sizes.s100),
                      Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => print("Tapped"),
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                  child:
                                      Text("Visit us at www.freetek.com.ng")),
                            ),
                          ))
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
