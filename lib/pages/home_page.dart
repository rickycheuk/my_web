import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_web/constants.dart';
import 'package:my_web/utils/CustomExpansionPanelList.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.userName,
    required this.description,
    required this.links,
    required this.websiteNames,
    required this.icons,
    required this.appList,
  }) : super(key: key);
  final String userName;
  final String description;
  final List links;
  final List websiteNames;
  final List icons;
  final List<Item> appList;

  @override
  _HomePageState createState() => _HomePageState();
}

double scrollTo = 0.0;
bool appExpanded = false;

class _HomePageState extends State<HomePage> {
  final itemKey = GlobalKey();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<Widget> homeViewList = [
      SingleChildScrollView(
          controller: scrollController,
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
                  height: 100,
                  width: min(width, 500),
                  alignment: Alignment.center,
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 20,
                          width: 20,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: widget.links.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 60,
                          width: 60,
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
                          child: TextButton(
                            onPressed: () async {
                              await HapticFeedback.lightImpact();
                              launch(widget.links[index]);
                            },
                            child: Icon(
                              widget.icons[index],
                              color: kSecondaryColor,
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
                  height: appExpanded ? widget.appList.length * 100 + 500 : widget.appList.length * 100,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(children: [
                    CustomExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          for (var item in widget.appList) {
                            item.isExpanded = false;
                          }
                          widget.appList[index].isExpanded = !isExpanded;
                          appExpanded = widget.appList[index].isExpanded;
                          print(appExpanded);
                          scrollTo = 300.0 + 80.0 * index;
                          scrollController.animateTo(scrollTo,
                              duration: const Duration(milliseconds: 420), curve: Curves.easeIn);
                        });
                      },
                      key: itemKey,
                      color: Theme.of(context).colorScheme.primary,
                      //.withOpacity(0.7),
                      screenWidth: min(width, 500),
                      radius: 10.0,
                      children: widget.appList.map<ExpansionPanel>((Item item) {
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
                                      color: kSecondaryColor,
                                      size: 24,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(item.headerValue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.apply(color: kSecondaryColor, fontWeightDelta: 2, fontSizeDelta: 1)),
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
          ) // ))),
          // ]
          ),
    ];

    return PageView(scrollDirection: Axis.vertical, children: homeViewList);
  }
}
