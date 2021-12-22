import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';
import 'package:flutter_rounded_progress_bar/flutter_icon_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class EmojiWallPage extends StatelessWidget {
  const EmojiWallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Spacer(),
          const Center(
              child: Text("Emoji Wall 😊", style: TextStyle(fontSize: 22),)
          ),
          Spacer(),
          Center(
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  "In Progress...",
                  speed: const Duration(milliseconds: 100),
                ),
              ]
            )
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: IconRoundedProgressBar(
              milliseconds:1000,
              widthIconSection: 70,
              percent: 33,
              icon: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.wifi_protected_setup, color: kSecondaryColor)),
              style: RoundedProgressBarStyle(
                backgroundProgress: const Color(0xFF9BA8B3),
                colorProgress: colorProgressBlue,
                colorProgressDark: colorProgressBlueDark,
                colorBorder: const Color(0xFFB5C4D0),
                colorBackgroundIcon: const Color(0xFFB5C4D0),
                widthShadow: 3,
                borderWidth: 3,
              ),
              borderRadius: BorderRadius.circular(30))
          ),
          Spacer(),
        ],
      )

    );
  }
}