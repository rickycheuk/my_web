import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> links = <String>[
  'https://www.linkedin.com/in/rickycheuk/',
  'https://github.com/rickycheuk',
  'https://twitter.com/ThlipperyT',
  'https://www.instagram.com/thlipperythnake/?hl=en'
];
final List<String> websiteNames = <String>['Linkedin','GitHub', 'Twitter', 'Instagram'];
final List<IconData> icons = <IconData>[Icons.web, Icons.web, Icons.web, Icons.web];
const my_name = 'Ricky Cheuk';
const description = '''Software Engineer''';

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
                backgroundImage: AssetImage('assets/images/rickycheuk.jpg')),
            Spacer(),
            Text(
              my_name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
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
