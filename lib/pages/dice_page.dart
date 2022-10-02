import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_page_container.dart';
import '../utils/button_widgets.dart';

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
      duration: const Duration(seconds: 5),
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
    final itemKey = GlobalKey();
    return AppPageContainer(
      key: itemKey,
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
                width: 35,
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
          height: 30,
        ),
        iconTextButton(
          buttonColor: _firstPress ? Theme.of(context).colorScheme.primary : Colors.grey,
          icon: Icons.rotate_left_rounded,
          textColor: Theme.of(context).colorScheme.secondary,
          text: 'Roll',
          onPressed: () async {
            if (_firstPress == true) {
              _firstPress = false;
              _controller.forward();
              await HapticFeedback.lightImpact();
              await diceChanger();
              await FirebaseAnalytics.instance.logEvent(
                name: "rolled_dice_$answer",
              );
            }
          },
        ),
        Container(
          height: 10,
        ),
      ],
    );
  }
}
