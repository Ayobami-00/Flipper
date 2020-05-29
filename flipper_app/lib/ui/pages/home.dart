import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double app_height = MediaQuery.of(context).size.height;
    double app_width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                      image: AssetImage(
                        "images/cube-3324923.jpg",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.darken)),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: app_height / 60),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    height: app_height / 5,
                                    width: app_width / 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: CircleAvatar(
                                      foregroundColor: Colors.white,
                                      child: Image.asset(
                                        "images/woman-159169.png",
                                        fit: BoxFit.cover,
                                        height: app_height / 15,
                                        width: app_width / 10,
                                      ),
                                    )),
                                InkWell(
                                  onTap: () => print("Tapped"),
                                  child: Text("ARIANA",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0)),
                                ),
                                Container(
                                  height: app_height / 5,
                                  width: app_width / 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                      child: Text("10",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30.0))),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: app_height / 5),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () => print("Tapped"),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.green),
                              child: Center(
                                  child: Text("NEW GAME",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32.0))),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () => print("Tapped"),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.green),
                              child: Center(
                                  child: Text("HIGH SCORES",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32.0))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: app_height / 5),
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
