import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:my_web/constants.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? textColor = Theme.of(context).textTheme.bodyText1?.color;
    return Container(
        color: Colors.transparent,
        child: Column(children: [
          const Spacer(),
          // const Center(
          //     child: Text(
          //       "Games",
          //       style: TextStyle(fontSize: 22),
          //     )),
          Container(
            width: min(MediaQuery.of(context).size.width, 500),
            height: 100,
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
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Games",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Spacer(),
          Container(
              width: min(MediaQuery.of(context).size.width, 500),
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: SizedBox(
                  height: 50,
                  child: LiquidLinearProgressIndicator(
                    value: 0.30,
                    valueColor:
                        AlwaysStoppedAnimation(kPrimaryColor.withOpacity(0.5)),
                    backgroundColor: textColor == kContentColorDarkTheme
                        ? kSecondaryColor
                        : kContentColorDarkTheme,
                    borderColor: kPrimaryColor,
                    borderWidth: 3.0,
                    borderRadius: 10.0,
                    direction: Axis.horizontal,
                    center:
                        AnimatedTextKit(repeatForever: true, animatedTexts: [
                      TypewriterAnimatedText(
                        "Stay Tuned...",
                        speed: const Duration(milliseconds: 100),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                    ]),
                  ))),
          const Spacer(),
        ]));
  }
}
