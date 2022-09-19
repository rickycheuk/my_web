import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/constants.dart';

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with SingleTickerProviderStateMixin {
  List<AssetImage> faces = const [
    AssetImage("assets/images/one.png"),
    AssetImage("assets/images/two.png"),
    AssetImage("assets/images/three.png"),
    AssetImage("assets/images/four.png"),
    AssetImage("assets/images/five.png"),
    AssetImage("assets/images/six.png"),
  ];
  late AnimationController _controller;
  late AssetImage diceImage1, diceImage2;
  var answer = "Press button to start";
  bool _firstPress = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    setState(() {
      diceImage1 = faces[0];
      diceImage2 = faces[0];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> diceChanger() async {
    int random = 1;
    int anotherRandom = 1;
    int rollCount = 10;
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
          _controller.reset();
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
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: min(MediaQuery.of(context).size.width, 500),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: textColor == kContentColorDarkTheme
                            ? Colors.black.withOpacity(0.420)
                            : Colors.white.withOpacity(0.420),
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
                            alignment: Alignment.center,
                            transformAlignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 30.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RotationTransition(
                                  turns: Tween(begin: 0.0, end: 6.9).animate(_controller),
                                  child: Image(
                                    image: diceImage1,
                                    width: 120.0,
                                    height: 120.0,
                                  ),
                                ),
                                Container(
                                  width: 30,
                                ),
                                RotationTransition(
                                  turns: Tween(begin: 0.0, end: 6.9).animate(_controller),
                                  child: Image(
                                    image: diceImage2,
                                    width: 120.0,
                                    height: 120.0,
                                  ),
                                ),
                              ],
                            ),
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
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                height: 60,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _firstPress ? Theme.of(context).colorScheme.primary : Colors.grey,
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
                                      _controller.forward();
                                      await HapticFeedback.lightImpact();
                                      await diceChanger();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.rotate_left_rounded,
                                    color: Theme.of(context).colorScheme.secondary,
                                    size: 24,
                                  ),
                                  label: Text('Roll',
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.secondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              )),
                          Container(
                            height: 10,
                          ),
                        ],
                      )),
                ])));
  }
}
