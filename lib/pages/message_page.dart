import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';

final _fireStore = FirebaseFirestore.instance;

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyText1?.color as Color;
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
                      child: Column(children: [
                        Container(
                          width: min(MediaQuery.of(context).size.width, 500),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: emailController,
                            minLines: 5,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              hintText: 'Enter message here...',
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Container(
                              height: 60,
                              width: 150,
                              // margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: kGradient1, width: 3),
                                color: Theme.of(context).colorScheme.primary,
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
                                  String sendMessage =
                                      emailController.text == "" ? "Message cannot be empty" : "Message sent";
                                  if (emailController.text != "") {
                                    var uuid = Uuid();
                                    // send email
                                    await _fireStore
                                        .collection('messages')
                                        .doc('${userId}.${uuid.v4()}')
                                        .set({'message': emailController.text}, SetOptions(merge: true));
                                  }
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          alignment: Alignment.center,
                                          title: Text(
                                            sendMessage,
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Form(
                                              child: Column(
                                                children: <Widget>[
                                                  _buildTextButton(
                                                      textColor: textColor,
                                                      height: 40,
                                                      text: "OK",
                                                      onPressed: () {
                                                        // HapticFeedback.lightImpact();
                                                        Navigator.pop(context);
                                                      })
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                  emailController.clear();
                                },
                                icon: Icon(
                                  Icons.mail_outline_rounded,
                                  color: Theme.of(context).colorScheme.secondary,
                                  size: 24,
                                ),
                                label: Text('Send',
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            )),
                        Container(
                          height: 10,
                        ),
                      ]))
                ])));
  }

  Widget _buildTextButton(
      {Color textColor = Colors.white, double height = 20, String text = "Button", void Function()? onPressed}) {
    return TextButton(
        child: Container(
            height: height,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 13),
            )),
        style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0), side: BorderSide(color: textColor, width: 2)))),
        onPressed: onPressed);
  }
}
