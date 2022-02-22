// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../constants.dart';
//
// class Dice extends StatefulWidget {
//   @override
//   _DiceState createState() => _DiceState();
// }
//
// class _DiceState extends State<Dice> {
//   List<AssetImage> faces = [
//     AssetImage("assets/images/one.png"),
//     AssetImage("assets/images/two.png"),
//     AssetImage("assets/images/three.png"),
//     AssetImage("assets/images/four.png"),
//     AssetImage("assets/images/five.png"),
//     AssetImage("assets/images/six.png"),
//   ];
//
//   late AssetImage HomeImage1, HomeImage2;
//   var answer = "Try out your Luck";
//
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       HomeImage1 = faces[0];
//       HomeImage2 = faces[0];
//     });
//   }
//
//   Future<void> diceChanger() async {
//     int random = 1;
//     int anotherRandom = 1;
//     int rollCount = 30;
//     for (var i = 0; i < rollCount; i++) {
//       random = (1 + Random().nextInt(6));
//       anotherRandom = (1 + Random().nextInt(6));
//
//       setState(() {
//         HomeImage1 = faces[random - 1];
//         HomeImage2 = faces[anotherRandom - 1];
//         if (i == rollCount - 1) {
//           answer = (random + anotherRandom).toString();
//         }
//       });
//       if (i < rollCount - 1) {
//         await Future.delayed(Duration(milliseconds: 90 + i * 9));
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Color? textColor = Theme.of(context).textTheme.bodyText1?.color;
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       alignment: Alignment.center,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               answer,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: textColor,
//                 fontSize: 38.0,
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 0.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Image(
//                     image: HomeImage1,
//                     width: 150.0,
//                     height: 150.0,
//                   ),
//                   Container(
//                     width: 10,
//                   ),
//                   Image(
//                     image: HomeImage2,
//                     width: 150.0,
//                     height: 150.0,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//                 alignment: Alignment.center,
//                 margin: EdgeInsets.only(top: 100.0),
//                 child: Container(
//                   height: 60,
//                   width: min(width, 200),
//                   // margin: const EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     // border: Border.all(color: kGradient1, width: 3),
//                     color: Theme.of(context).colorScheme.primary,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.5),
//                         blurRadius: 3,
//                         offset: const Offset(1, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: TextButton.icon(
//                     onPressed: () async {
//                       await HapticFeedback.lightImpact();
//                       diceChanger();
//                     },
//                     icon: const Icon(
//                       Icons.rotate_left_rounded,
//                       color: kSecondaryColor,
//                       size: 24,
//                     ),
//                     label: const Text('Roll',
//                         style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 15)),
//                   ),
//                 )
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
