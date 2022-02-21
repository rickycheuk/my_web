import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

List<Item> L = [
  Item(headerValue: 'Skills', expandedValue: """
- Technical: Python, Unix, Git, SQL, Flutter, Spark
- Languages: Cantonese, English, Mandarin
"""),
  Item(headerValue: 'Background', expandedValue: """
- B.S. in Information Systems
- 3.5 years in FinTech
"""),
  Item(headerValue: 'Current Work', expandedValue: """
- Big data processing
- Workflow automation
- API integration
"""),
  Item(headerValue: 'More', expandedValue: """
- Hong Kong -> New York
- Used to dance in college
- Can speak 3 Chinese dialects
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
      Flex(
          direction: isScreenWide ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: isScreenWide ? 300 : 400,
                      maxWidth: isScreenWide ? 300 : 800,
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      //isScreenWide ? Axis.horizontal : Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: SizedBox(
                            width: isScreenWide ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width,
                            height: isScreenWide
                                ? MediaQuery.of(context).size.height
                                : MediaQuery.of(context).size.height / 3,
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
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              width:
                                  isScreenWide ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width,
                              child: Align(
                                  alignment: isScreenWide
                                      ? const Alignment(0, -1.0) //const Alignment(0, 0.0)
                                      : const Alignment(0, -1.0),
                                  child: ListView.separated(
                                      separatorBuilder: (BuildContext context, int index) {
                                        return const SizedBox(height: 10);
                                      },
                                      scrollDirection: Axis.vertical,
                                      //isScreenWide ? Axis.horizontal : Axis.vertical,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(10),
                                      itemCount: widget.links.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Align(
                                            alignment: const Alignment(0, -1.0),
                                            child: Container(
                                                height: 60,
                                                width: min(MediaQuery.of(context).size.width, 500),
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: kGradient1, width: 3),
                                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                                ),
                                                child: TextButton.icon(
                                                    onPressed: () => launch(widget.links[index]),
                                                    icon: Icon(
                                                      widget.icons[index],
                                                      color: kSecondaryColor,
                                                      size: 16,
                                                    ),
                                                    label: Text(widget.websiteNames[index],
                                                        style: const TextStyle(
                                                            color: kSecondaryColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14)))));
                                      }))),
                        ),
                        _buildScrollIndicator(),
                      ],
                    ))),
          ]),
      aboutPage(isScreenWide, width, textColor)
    ];

    return PageView(scrollDirection: Axis.vertical, children: homeViewList);
  }

  Widget _buildScrollPage(bool isScreenWide, double width, Color? textColor) {
    return PageView(scrollDirection: Axis.vertical, children: [
      welcomePage(width, textColor),
      aboutPage(isScreenWide, width, textColor),
    ]);
  }

  Widget welcomePage(double width, Color? textColor) {
    Color textC = textColor as Color;
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/ricky_boat.jpg"), fit: BoxFit.cover, alignment: Alignment.center),
        ),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: BoxDecoration(
                color: textC == kContentColorDarkTheme ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.4)),
            child: Flex(direction: Axis.vertical, children: [
              Expanded(
                  child: Container(
                      width: min(width, 600),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                        FlickerAnimatedText("Welcome",
                            // duration: const Duration(milliseconds: 6900),
                            textStyle: TextStyle(
                              fontSize: 69,
                              color: textC,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Horizon',
                              shadows: [
                                Shadow(
                                  blurRadius: 7.0,
                                  color: textC,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            )),
                      ]))),
              _buildScrollIndicator()
            ])));
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
                                for (var item in L) {
                                  item.isExpanded = false;
                                }
                                L[index].isExpanded = !isExpanded;
                              });
                            },
                            key: const Key(''),
                            color: textC == kContentColorDarkTheme
                                ? Colors.black.withOpacity(0.5)
                                : Colors.white.withOpacity(0.5),
                            screenWidth: width,
                            radius: 10.0,
                            children: L.map<ExpansionPanel>((Item item) {
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

  Widget _buildBubbles(String text, double length, Color color, Color textColor) {
    return Container(
        width: length,
        height: length,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: textColor, width: 2),
          color: color.withOpacity(0.7),
          // gradient: LinearGradient(colors: widget.bubbleData.colors)
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          // splashColor: widget.bubbleData.splashColor,
          onTap: () {
            if (kDebugMode) {
              print(text);
            }
          },
          child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              )),
        ));
  }

  Widget _buildAboutText() {
    return Flexible(
        child: ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 450,
        maxWidth: 450,
      ),
      child: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          """
  Skills:
      - Technical: Python, Unix, Git, SQL, Flutter, Spark
      - Languages: Cantonese, English, Mandarin
  
  Background:
      - B.S. in Information Systems
      - 3.5 years in FinTech
  
  Current Work: 
      - Big data processing
      - Workflow automation
      - API integration
            
  Fun Facts:
      - Hong Kong -> New York
      - Used to dance in college
      - Can speak 3 Chinese dialects
  """,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16),
        ),
      ),
    ));
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
