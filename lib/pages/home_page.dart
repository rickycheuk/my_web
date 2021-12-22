import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> links = <String>[
  'https://www.google.com/',
  'https://twitter.com/home'
];
final List<String> websiteNames = <String>['Google', 'Twitter'];
final List<IconData> icons = <IconData>[Icons.web, Icons.web];
const description = '''Software Engineer\nXXX''';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isScreenWide =
        MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height;
    return Flex(
      direction: isScreenWide ? Axis.horizontal : Axis.vertical,
      children: <Widget>[
        Container(
          width: isScreenWide
              ? MediaQuery.of(context).size.width / 2
              : MediaQuery.of(context).size.width,
          height: isScreenWide
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height / 3,
          child: Column(children: const <Widget>[
            Spacer(),
            CircleAvatar(
                minRadius: 20,
                maxRadius: 60,
                backgroundImage: NetworkImage(
                    'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg')),
            Spacer(),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            Spacer(),
          ]),
        ),
        Container(
            color: Colors.transparent,
            width: isScreenWide
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                itemCount: links.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 50,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: TextButton.icon(
                          onPressed: () => launch(links[index]),
                          icon: Icon(icons[index], color: kSecondaryColor),
                          label: Text(websiteNames[index],
                              style: const TextStyle(color: kSecondaryColor))));
                })),
      ],
    );
  }
}
