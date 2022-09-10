import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram_public_api/instagram_public_api.dart';

import '../main.dart';

final _fireStore = FirebaseFirestore.instance;

class InstagramPage extends StatefulWidget {
  const InstagramPage({Key? key}) : super(key: key);

  @override
  _InstagramPageState createState() => _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  TextEditingController emailController = TextEditingController();
  late List<InstaPost> post;

  @override
  void initState(){
    super.initState();
    getInstagramData();
  }

  Future<void> getInstagramData() async {
    final List<InstaPost> p = await FlutterInsta().getPostData(
        "https://www.instagram.com/p/CLXXql8gwpo/?utm_source=ig_web_copy_link");
    setState(() {

      post=p;
      for (int i = 0; i < post.length; i++) {
        print(post[i].thumbnailUrl);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyText1?.color as Color;
    return SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Container(
                width: min(MediaQuery.of(context).size.width, 500),
                height: 75,
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
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 3,
                      offset: const Offset(1, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Test",
                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
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
