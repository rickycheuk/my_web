import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_web/pages/all_pages.dart';
import 'package:my_web/theme.dart';

import 'constants.dart';
import 'firebase_options.dart';

final _fireStore = FirebaseFirestore.instance;
const profileId = 'Tiqrj06AHigcHiytJPf1';
String webTitle = 'Ricky Cheuk';
String description = 'Software Engineer';
String userName = 'Ricky Cheuk';
List<Widget> tabPages = [
  EmojiWallPage(),
  HomePage(
    userName: userName,
    description: description,
    links: const [
      'https://www.linkedin.com/in/rickycheuk/',
      'https://github.com/rickycheuk',
      'https://twitter.com/ThlipperyT',
      'https://www.instagram.com/thlipperythnake/?hl=en'
    ],
    websiteNames: const ['Linkedin', 'GitHub', 'Twitter', 'Instagram'],
    icons: const [
      Icons.web,
      Icons.web,
      Icons.web,
      Icons.web],
  ),
  // ContactPage(),
];
var _brightness = SchedulerBinding.instance!.window.platformBrightness;
bool isDarkMode = _brightness == Brightness.dark;

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: webTitle,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeMode,
      home: Page(title: webTitle),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  Future<void> getData() async {
    List _links = [];
    List _websiteNames = [];
    List _icons = [];
    QuerySnapshot querySnapshot = await _fireStore.collection('urls').get();
    DocumentSnapshot profileSnapshot =
        await _fireStore.collection('profile').doc(profileId).get();
    final allData =
        querySnapshot.docs.map((doc) => doc.data()).toList() as List;
    for (var d in allData) {
      _links.add(d['link']);
      _websiteNames.add(d['name']);
      switch (d['icon'].toLowerCase()) {
        case 'linkedin':
          {
            _icons.add(Icons.account_circle_outlined);
          }
          break;
        default:
          {
            _icons.add(Icons.web);
          }
          break;
      }
    }
    setState(() {
      webTitle = profileSnapshot['name'];
      userName = profileSnapshot['name'];
      description = profileSnapshot['description'];
      tabPages = [
        HomePage(
            userName: userName,
            description: description,
            links: _links,
            websiteNames: _websiteNames,
            icons: _icons),
        EmojiWallPage(),
        // ContactPage(),
      ];
    });
    print(webTitle);
    print(_links);
  }
}

class Page extends StatefulWidget {
  const Page({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  int _pageIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: PageView(
          children: tabPages,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
        bottomNavigationBar: _buildBottomNavigationBar());
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Widget _buildBottomNavigationBar() {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kGradient1,
              kGradient2,
              kGradient1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.5, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
          child: BottomNavigationBar(
            currentIndex: _pageIndex,
            onTap: onTabTapped,
            elevation: 50.0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sentiment_satisfied_alt),
                  label: 'Emoji Wall'),
            ],
          ),
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    ThemeMode? _themeMode = MyApp.of(context)?._themeMode;
    return PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _themeMode == ThemeMode.light ? kGradient1 : Colors.black,
                  _themeMode == ThemeMode.light ? kGradient2 : Colors.black,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 1],
                tileMode: TileMode.clamp,
              ),
            ),
            child: AppBar(
              title: Text(widget.title),
              // centerTitle: true,
              elevation: 0.0,
              bottomOpacity: 0.5,
              actions: [
                IconButton(
                  icon: Icon(
                      _themeMode == ThemeMode.light
                          ? Icons.dark_mode
                          : Icons.wb_sunny_outlined,
                      color: kContentColorDarkTheme),
                  onPressed: () {
                    MyApp.of(context)?._themeMode == ThemeMode.light
                        ? MyApp.of(context)?.changeTheme(ThemeMode.dark)
                        : MyApp.of(context)?.changeTheme(ThemeMode.light);
                    setState(() {
                      _themeMode = MyApp.of(context)?._themeMode;
                    });
                  },
                ),
              ],
            )));
  }
}
