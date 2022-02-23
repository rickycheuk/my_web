import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/constants.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  List<AssetImage> faces = const [
    AssetImage("assets/images/one.png"),
    AssetImage("assets/images/two.png"),
    AssetImage("assets/images/three.png"),
    AssetImage("assets/images/four.png"),
    AssetImage("assets/images/five.png"),
    AssetImage("assets/images/six.png"),
  ];

  late AssetImage diceImage1, diceImage2;
  var answer = "Press button to start";
  bool _firstPress = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      diceImage1 = faces[0];
      diceImage2 = faces[0];
    });
  }

  Future<void> diceChanger() async {
    int random = 1;
    int anotherRandom = 1;
    int rollCount = 25;
    for (var i = 0; i < rollCount; i++) {
      random = (1 + Random().nextInt(6));
      anotherRandom = (1 + Random().nextInt(6));

      setState(() {
        diceImage1 = faces[random - 1];
        diceImage2 = faces[anotherRandom - 1];
        _firstPress = false;
        if (i == rollCount - 1) {
          answer = (random + anotherRandom).toString();
          _firstPress = true;
        }
      });
      if (i < rollCount - 1) {
        await Future.delayed(Duration(milliseconds: 90 + i * 9));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor = Theme.of(context).textTheme.bodyText1?.color;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Container(
                width: min(MediaQuery.of(context).size.width, 500),
                height: 75,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kGradient1.withOpacity(0.8),
                      kGradient2.withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.0, 1],
                    tileMode: TileMode.clamp,
                  ),
                  border: Border.all(color: kGradient1, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 3,
                      offset: const Offset(1, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Apps",
                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              Container(
                  width: min(MediaQuery.of(context).size.width, 500),
                  height: 450,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: textColor == kContentColorDarkTheme
                        ? Colors.black.withOpacity(0.3)
                        : Colors.white.withOpacity(0.3),
                    // border: Border.all(color: kGradient1, width: 3),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3,
                        offset: const Offset(1, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                      ),
                      Text(
                        "Dice Roller",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 36.0,
                        ),
                      ),
                      Container(
                        height: 30,
                      ),
                      Text(
                        answer,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 28.0,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        transformAlignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: diceImage1,
                              width: 120.0,
                              height: 120.0,
                            ),
                            Container(
                              width: 20,
                            ),
                            Image(
                              image: diceImage2,
                              width: 120.0,
                              height: 120.0,
                            ),
                          ],
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            height: 60,
                            width: min(width, 200),
                            // margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(color: kGradient1, width: 3),
                              color: _firstPress? Theme.of(context).colorScheme.primary: Colors.grey,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 3,
                                  offset: const Offset(1, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton.icon(
                              onPressed: () async {
                                if (_firstPress == true) {
                                  _firstPress = false;
                                  await HapticFeedback.lightImpact();
                                  await diceChanger();
                                }
                              },
                              icon: const Icon(
                                Icons.rotate_left_rounded,
                                color: kSecondaryColor,
                                size: 24,
                              ),
                              label: const Text('Roll',
                                  style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 20)),
                            ),
                          )),
                    ],
                  )),
            ])));
  }
}
