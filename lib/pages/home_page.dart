import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';
import 'package:url_launcher/url_launcher.dart';

const my_name = 'Ricky Cheuk';
const description = '''Software Engineer''';

class HomePage extends StatelessWidget {
  const HomePage(
      {Key? key,
      required this.links,
      required this.websiteNames,
      required this.icons})
      : super(key: key);
  final List links;
  final List websiteNames;
  final List icons;

  @override
  Widget build(BuildContext context) {
    bool isScreenWide =
        MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;
    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: <Widget>[
        Flexible(
          child: SizedBox(
            // margin: const EdgeInsets.all(20.0),
            width: isScreenWide
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width,
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
                      maxRadius: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.asset('assets/images/rickycheuk.jpg'),
                      )),
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      my_name,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
        Flexible(
          child: SizedBox(
              width: isScreenWide
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              child: Align(
                  alignment: isScreenWide
                      ? const Alignment(0, 0.0)
                      : const Alignment(0, -1.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      //isScreenWide ? Axis.horizontal : Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: links.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                            alignment: const Alignment(0, -1.0),
                            child: Container(
                                height: 50,
                                width:
                                    min(MediaQuery.of(context).size.width, 600),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border:
                                      Border.all(color: kGradient1, width: 3),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.7),
                                ),
                                child: TextButton.icon(
                                    onPressed: () => launch(links[index]),
                                    icon: Icon(icons[index],
                                        color: kSecondaryColor),
                                    label: Text(websiteNames[index],
                                        style: const TextStyle(
                                            color: kSecondaryColor,
                                            fontWeight: FontWeight.bold)))));
                      }))),
        ),
      ],
    );
  }
}
