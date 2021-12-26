import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';

final _fireStore = FirebaseFirestore.instance;
const title = 'Emoji Wall';
const description = 'Add your emoji here ->';

class EmojiWallPage extends StatefulWidget {
  const EmojiWallPage({Key? key}) : super(key: key);

  @override
  _EmojiWallPageState createState() => _EmojiWallPageState();
}

class _EmojiWallPageState extends State<EmojiWallPage> {
  String _currentEmoji = '+';
  String emojis = '';
  String _userId = '';

  @override
  void initState() {
    super.initState();
    getEmojiData();
  }

  Future<void> getEmojiData() async {
    String _emojis = '';
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    print(userCredential.user?.uid);
    QuerySnapshot querySnapshot = await _fireStore.collection('emojis').get();
    DocumentSnapshot userSnapshot = await _fireStore.collection('emojis').doc(userCredential.user?.uid).get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList() as List;
    for (var d in allData) {
      _emojis += d['emoji'];
    }
    setState(() {
      emojis = _emojis;
      _userId = userCredential.user?.uid as String;
      _currentEmoji = userSnapshot.exists ? userSnapshot['emoji'] : '+';
    });
  }

  void onEmojiChanged(String emoji) {
    setState(() {
      _currentEmoji = emoji;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: min(MediaQuery.of(context).size.width, 600),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              child: Container(
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
                child: Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Text(
                          title,
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        AnimatedTextKit(repeatForever: true, animatedTexts: [
                          TypewriterAnimatedText(
                            description,
                            speed: const Duration(milliseconds: 100),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: TextButton(
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              _currentEmoji,
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                            )),
                        style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all(kGradient1.withOpacity(0.8)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0), side: const BorderSide(color: Colors.white, width: 3)))),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  alignment: Alignment.center,
                                  title: const Text(
                                    'Add Your Emoji',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width / 1.5,
                                              height: MediaQuery.of(context).size.height / 1.5,
                                              child: GridView.count(
                                                crossAxisCount: (MediaQuery.of(context).size.width / 70).round() - 1,
                                                padding: const EdgeInsets.all(1.0),
                                                children: List.generate(emojiList.length, (index) {
                                                  return Container(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        onEmojiChanged(emojiList[index]);
                                                        _fireStore
                                                            .collection('emojis')
                                                            .doc(_userId)
                                                            .set({'emoji': emojiList[index]}, SetOptions(merge: true));
                                                        getEmojiData();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        emojiList[index],
                                                        style: const TextStyle(fontSize: 20),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ]),
              ),
            ),

            Flexible(
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(10.0),
                // decoration: BoxDecoration(
                //     color: Colors.black12.withOpacity(0.2),
                //     border: Border.all(color: Colors.black12.withOpacity(0.2), width: 3),
                //     borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: SingleChildScrollView(
                  child: Text(
                    emojis.replaceAll('\n', ''),
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // Spacer(),
            // const Center(
            //     child: Text(
            //   "Emoji Wall 😊",
            //   style: TextStyle(fontSize: 22),
            // )),
            // Spacer(),
            // Center(
            //     child: AnimatedTextKit(repeatForever: true, animatedTexts: [
            //   TypewriterAnimatedText(
            //     "In Progress...",
            //     speed: const Duration(milliseconds: 100),
            //   ),
            // ])),
            // Container(
            //     padding: const EdgeInsets.all(20),
            //     child: IconRoundedProgressBar(
            //         milliseconds: 1000,
            //         widthIconSection: 70,
            //         percent: 33,
            //         icon: const Padding(
            //             padding: EdgeInsets.all(8),
            //             child: Icon(Icons.wifi_protected_setup,
            //                 color: kSecondaryColor)),
            //         style: RoundedProgressBarStyle(
            //           backgroundProgress: const Color(0xFF9BA8B3),
            //           colorProgress: colorProgressBlue,
            //           colorProgressDark: colorProgressBlueDark,
            //           colorBorder: const Color(0xFFB5C4D0),
            //           colorBackgroundIcon: const Color(0xFFB5C4D0),
            //           widthShadow: 3,
            //           borderWidth: 3,
            //         ),
            //         borderRadius: BorderRadius.circular(30))),
            // Spacer(),
          ],
        ));
  }
}
