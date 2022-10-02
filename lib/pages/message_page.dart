import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import '../utils/app_page_container.dart';
import '../utils/button_widgets.dart';

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
    final itemKey = GlobalKey();
    return AppPageContainer(key: itemKey, children: [
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
      iconTextButton(
        buttonColor: Theme.of(context).colorScheme.primary,
        icon: Icons.mail_outline_rounded,
        textColor: Theme.of(context).colorScheme.secondary,
        text: 'Send',
        onPressed: () async {
          String sendMessage = emailController.text == "" ? "Message cannot be empty" : "Message sent";
          if (emailController.text != "") {
            var uuid = const Uuid();
            // send email
            await _fireStore
                .collection('messages')
                .doc('$userId.${uuid.v4()}')
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
                          plainTextButton(
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
      ),
      Container(
        height: 10,
      ),
    ]);
  }
}
