import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/constants.dart';
import 'package:my_web/utils/CustomExpansionPanelList.dart';
import 'package:url_launcher/url_launcher.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> aboutList = [
  Item(headerValue: 'Skills', expandedValue: """
• Technical: Python, Unix, Git, SQL, Flutter, Spark
• Languages: Cantonese, English, Mandarin
"""),
  Item(headerValue: 'Background', expandedValue: """
• B.S. in Information Systems
• 3.5 years in FinTech
"""),
  Item(headerValue: 'Current Work', expandedValue: """
• Big data processing
• Workflow automation
• API integration
"""),
  Item(headerValue: 'More', expandedValue: """
• Hong Kong -> New York
• Used to dance in college
• Can speak 3 Chinese dialects
"""),
];

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.userName,
    required this.description,
    required this.links,
    required this.websiteNames,
    required this.icons,
  }) : super(key: key);
  final String userName;
  final String description;
  final List links;
  final List websiteNames;
  final List icons;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color? textColor = Theme.of(context).textTheme.bodyText1?.color;
    bool isScreenWide = MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<Widget> homeViewList = [
      SingleChildScrollView(
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
                        child: Image.asset('assets/images/ricky.jpg'),
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
              padding: const EdgeInsets.all(10),
              width: width,
              child: Align(
                  alignment: isScreenWide
                      ? const Alignment(0, -1.0) //const Alignment(0, 0.0)
                      : const Alignment(0, -1.0),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 15);
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: widget.links.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                            alignment: const Alignment(0, -1.0),
                            child: Container(
                              height: 60,
                              width: min(width, 500),
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
                                  await HapticFeedback.lightImpact();
                                  launch(widget.links[index]);
                                },
                                icon: Icon(
                                  widget.icons[index],
                                  color: kSecondaryColor,
                                  size: 24,
                                ),
                                label: Text(widget.websiteNames[index],
                                    style: const TextStyle(
                                        color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 15)),
                              ),
                            ));
                      }))),
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
                      for (var item in aboutList) {
                        item.isExpanded = false;
                      }
                      aboutList[index].isExpanded = !isExpanded;
                    });
                  },
                  key: const Key(''),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  screenWidth: min(width, 500),
                  radius: 10.0,
                  children: aboutList.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.headerValue,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.apply(color: kSecondaryColor, fontWeightDelta: 2)),
                        );
                      },
                      body: ListTile(
                        subtitle: Text(item.expandedValue, style: const TextStyle(color: kSecondaryColor)),
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                )
              ]))
          // _buildScrollIndicator(),
        ],
      ) // ))),
          // ]
          ),
      // aboutPage(isScreenWide, width, textColor)
    ];

    return PageView(scrollDirection: Axis.vertical, children: homeViewList);
  }

  Widget aboutPage(bool isScreenWide, double width, Color? textColor) {
    Color textC = textColor as Color;
    return Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ricky_beach.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
                color: textC == kContentColorDarkTheme ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.7)),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: isScreenWide ? Axis.horizontal : Axis.vertical,
              children: [
                Flexible(
                    child: Column(children: [
                  Container(
                    width: min(width, 500),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      "About",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  // _buildAboutText()
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: CustomExpansionPanelList(
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                for (var item in aboutList) {
                                  item.isExpanded = false;
                                }
                                aboutList[index].isExpanded = !isExpanded;
                              });
                            },
                            key: const Key(''),
                            color: textC == kContentColorDarkTheme
                                ? Colors.black.withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                            screenWidth: width,
                            radius: 10.0,
                            children: aboutList.map<ExpansionPanel>((Item item) {
                              return ExpansionPanel(
                                canTapOnHeader: true,
                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return ListTile(
                                    title: Text(item.headerValue),
                                  );
                                },
                                body: ListTile(
                                  title: Text(item.expandedValue),
                                ),
                                isExpanded: item.isExpanded,
                              );
                            }).toList(),
                          ))),
                ])),
              ],
            )));
  }

  Widget _buildScrollIndicator() {
    return Container(
        padding: const EdgeInsets.all(1),
        height: 70,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedTextKit(repeatForever: true, animatedTexts: [
              FadeAnimatedText("Scroll",
                  duration: const Duration(milliseconds: 800),
                  textStyle: const TextStyle(fontSize: 12, color: kPrimaryColor)),
            ]),
            Container(
              height: 3,
            ),
            const Icon(
              Icons.arrow_circle_down_rounded,
              semanticLabel: 'Scroll',
              size: 30,
              color: kPrimaryColor,
            ),
          ],
        ));
  }
}
