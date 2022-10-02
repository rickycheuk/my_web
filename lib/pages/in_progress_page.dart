// import 'dart:math';
//
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:my_web/constants.dart';
//
// class InProgressPage extends StatelessWidget {
//   const InProgressPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Color? textColor = Theme.of(context).textTheme.bodyText1?.color;
//     return SingleChildScrollView(
//         child: Container(
//             alignment: Alignment.center,
//             color: Colors.transparent,
//             padding: const EdgeInsets.all(20.0),
//             child: Column(children: [
//               Container(
//                 width: min(MediaQuery.of(context).size.width, 500),
//                 height: 75,
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       kGradient1.withOpacity(0.8),
//                       kGradient2.withOpacity(0.8),
//                     ],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                     stops: const [0.0, 1],
//                     tileMode: TileMode.clamp,
//                   ),
//                   border: Border.all(color: kGradient1, width: 3),
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.5),
//                       blurRadius: 3,
//                       offset: const Offset(1, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   alignment: Alignment.center,
//                   child: const Text(
//                     "Leave me a message",
//                     style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: 50,
//               ),
//               Container(
//                   width: min(MediaQuery.of(context).size.width, 500),
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.all(20),
//                   child: AnimatedTextKit(repeatForever: true, animatedTexts: [
//                     TypewriterAnimatedText(
//                       "Stay Tuned...",
//                       speed: const Duration(milliseconds: 100),
//                       textStyle: TextStyle(fontSize: 20),
//                     ),
//                   ])),
//               Container(
//                 height: 20,
//               ),
//             ])));
//   }
// }
