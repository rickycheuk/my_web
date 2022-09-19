import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';

final _fireStore = FirebaseFirestore.instance;
const title = 'Emoji Wall';
const description = 'Add your Emoji ->';

class EmojiWallPage extends StatefulWidget {
  const EmojiWallPage({Key? key, required this.userId, this.waitTime = 1}) : super(key: key);

  final String userId;
  final int waitTime;

  @override
  _EmojiWallPageState createState() => _EmojiWallPageState();
}

class _EmojiWallPageState extends State<EmojiWallPage> {
  String _currentEmoji = '+';
  Text emojis = const Text('');
  late Future _emojiFuture;
  final ScrollController _scrollController = ScrollController();
  String selectedValue = "Smiley";

  @override
  void initState() {
    _emojiFuture = getEmojiData(widget.waitTime);
    super.initState();
  }

  Future<void> getEmojiData(int wait) async {
    String _emojis = '';
    QuerySnapshot querySnapshot = await _fireStore.collection('emojis').get();
    DocumentSnapshot userSnapshot = await _fireStore.collection('emojis').doc(widget.userId).get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var d in allData) {
      _emojis += d['emoji'];
    }
    setState(() {
      emojis = Text(
        _emojis.replaceAll('\n', ''),
        style: const TextStyle(fontSize: 25, fontFamily: ''),
        textAlign: TextAlign.center,
      );
      _currentEmoji = userSnapshot.exists ? userSnapshot['emoji'] : '+';
    });
    await Future.delayed(Duration(seconds: wait));
  }

  void onEmojiChanged(String emoji) {
    setState(() {
      _currentEmoji = emoji;
    });
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
                    alignment: Alignment.topCenter,
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
                    height: 450,
                    child: Column(
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                                child: Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(10.0),
                          child: FutureBuilder(
                            future: _emojiFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                    backgroundColor: Colors.grey, color: kPrimaryColor);
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Error while loading Emojis. Please refresh."),
                                );
                              } else {
                                return emojis;
                              }
                            },
                          ),
                        ))),
                        Divider(
                          height: 10.0,
                          thickness: 2.0,
                          color: textColor?.withOpacity(0.420),
                        ),
                        Container(
                          width: min(MediaQuery.of(context).size.width, 500),
                          alignment: Alignment.center,
                          height: 69,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Stack(children: [
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  description,
                                  style: TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.bold),
                                )),
                            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: SizedBox(width: 45, height: 45, child: addEmojiButton(textColor: textColor)),
                              ),
                            ])
                          ]),
                        ),
                      ],
                    )),
              ],
            )));
  }

  Widget addEmojiButton({Color? textColor = Colors.white}) {
    return TextButton(
      child: Container(
          alignment: Alignment.center,
          child: Text(
            _currentEmoji,
            style: TextStyle(color: textColor, fontSize: 20),
          )),
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(kGradient1.withOpacity(0.69)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(69.0), side: BorderSide(color: textColor as Color, width: 3))),
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                List selectedList = emojiListMap[selectedValue];
                return AlertDialog(
                  scrollable: true,
                  alignment: Alignment.center,
                  title: Stack(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Text(
                                'Add Your Emoji',
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                height: 10,
                              ),
                              DropdownButton(
                                value: selectedValue,
                                items: emojiListNames.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                              )
                            ],
                          )),
                      Container(
                          alignment: Alignment.centerRight,
                          child: SizedBox(width: 45, height: 45, child: helpButton())),
                    ],
                  ),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: Column(
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Scrollbar(
                                thumbVisibility: true,
                                controller: _scrollController,
                                child: GridView.count(
                                  controller: _scrollController,
                                  crossAxisCount: (MediaQuery.of(context).size.width / 70).round() - 1,
                                  padding: const EdgeInsets.all(1.0),
                                  children: List.generate(selectedList.length, (index) {
                                    return Container(
                                      padding: const EdgeInsets.all(3.0),
                                      child: TextButton(
                                        onPressed: () async {
                                          loadingPopup();
                                          onEmojiChanged(selectedList[index]);
                                          await _fireStore
                                              .collection('emojis')
                                              .doc(widget.userId)
                                              .set({'emoji': selectedList[index]}, SetOptions(merge: true));
                                          await getEmojiData(0);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          selectedList[index],
                                          style: const TextStyle(fontSize: 20, fontFamily: ''),
                                        ),
                                      ),
                                    );
                                  }),
                                )))
                      ],
                    )),
                  ),
                );
              });
            });
      },
    );
  }

  Widget helpButton() {
    return TextButton(
      child: Container(
          alignment: Alignment.center,
          child: const Text(
            "?",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
      style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(kGradient1.withOpacity(0.7)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0), side: const BorderSide(color: Colors.white, width: 3)))),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                alignment: Alignment.center,
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView(
                              children: const [
                                Text(
                                  'What is Emoji Wall?',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  '  - A page for anyone to leave emojis anonymously',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '  - Each visitor can only add one emoji',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(''),
                                Text(
                                  'How does this work?',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  '  - Simply tap and select an emoji',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '  - You will see your current emoji on top right',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '  - Picking a new emoji will replace your previous one',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '  - New emojis might take few seconds to update, try refreshing the page',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Future loadingPopup() {
    return showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Updating your Emoji...')
                ],
              ),
            ),
          );
        });
  }
}
