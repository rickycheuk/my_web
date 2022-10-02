import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/pages/all_pages.dart';
import 'package:my_web/utils/CustomExpansionPanelList.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../models/game_model.dart';
import '../utils/my_web_icons.dart';

final _fireStore = FirebaseFirestore.instance;
Widget placeholderWidget = Container();

Stream<List<GameModel>> streamGameData() {
  var ref = _fireStore.collection('tictactoe');

  return ref.snapshots().map((list) => list.docs.map((doc) => GameModel.fromFirestore(doc)).toList());
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.userName,
    required this.description,
    required this.links,
    required this.websiteNames,
    required this.icons,
    required this.userId,
  }) : super(key: key);
  final String userName;
  final String description;
  final List links;
  final List websiteNames;
  final List icons;
  final String userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final itemKey = GlobalKey();
  List<Item> appList = [
    Item(
        headerValue: 'TicTacToe',
        expandedValue: StreamProvider<List<GameModel>>.value(
            value: streamGameData(),
            initialData: [],
            child: SlideTacToePage(
              userId: userId,
            )),
        icon: Icons.grid_3x3_rounded),
    Item(headerValue: 'Dice Roller', expandedValue: const DicePage(), icon: My_web.dice_six),
    Item(
        headerValue: 'Emoji Wall',
        expandedValue: EmojiWallPage(
          userId: userId,
        ),
        icon: Icons.sentiment_satisfied_alt),
    Item(headerValue: 'Message Me', expandedValue: const MessagePage(), icon: Icons.insert_comment_outlined),
    // Item(headerValue: 'Insta', expandedValue: InstagramPage(), icon: My_web.instagram_1),
  ];
  late List<Item> renderedAppList;

  @override
  void initState() {
    setState(() {
      renderedAppList = appList.map<Item>(
        (Item value) {
          return Item(headerValue: value.headerValue, expandedValue: placeholderWidget, icon: value.icon);
        },
      ).toList();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // List<Widget> homeViewList = [
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SizedBox(
          width: width,
          height: 200,
          child: Column(children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                    minRadius: 10,
                    maxRadius: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: const Image(image: AssetImage('assets/images/ricky.jpg')),
                    )),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.userName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ]),
        ),
        Container(
            height: 60,
            width: min(width, 500),
            alignment: Alignment.center,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                    width: 10,
                  );
                },
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.links.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        await HapticFeedback.lightImpact();
                        await launchUrl(Uri.parse(widget.links[index]));
                      },
                      child: Icon(
                        widget.icons[index],
                        color: Theme.of(context).colorScheme.secondary,
                        size: 24,
                      ),
                    ),
                  );
                })),
        Container(
          width: min(width, 500),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          alignment: Alignment.topCenter,
          child: Divider(
            thickness: 1.0,
            color: Colors.grey.withOpacity(0.7),
          ),
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(children: [
              CustomExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    for (var item in renderedAppList) {
                      item.isExpanded = false;
                    }
                    renderedAppList[index].isExpanded = !isExpanded;

                    if (renderedAppList[index].expandedValue == placeholderWidget &&
                        renderedAppList[index].isExpanded) {
                      renderedAppList[index].expandedValue = appList[index].expandedValue;
                    }
                  });
                },
                key: itemKey,
                color: Theme.of(context).colorScheme.primary,
                screenWidth: min(width, 500),
                radius: 10.0,
                children: renderedAppList.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                item.icon,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item.headerValue,
                                  style: Theme.of(context).textTheme.bodyText1?.apply(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontWeightDelta: 2,
                                      fontSizeDelta: 1)),
                            ],
                          ));
                    },
                    body: item.expandedValue,
                    isExpanded: item.isExpanded,
                  );
                }).toList(),
              )
            ]))
      ],
    ));
  }
}
