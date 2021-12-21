import 'package:my_web/theme.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:my_web/pages/all_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Web',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeMode,
      home: const Page(title: 'My Web'),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
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

  List<Widget> tabPages = [
    HomePage(),
    EmojiWallPage(),
    ContactPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode? _themeMode = MyApp.of(context)?._themeMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(_themeMode == ThemeMode.light? Icons.dark_mode : Icons.wb_sunny_outlined),
            onPressed: () {
              MyApp.of(context)?._themeMode == ThemeMode.light?
                MyApp.of(context)?.changeTheme(ThemeMode.dark): MyApp.of(context)?.changeTheme(ThemeMode.light);
              setState(() {
                _themeMode = MyApp.of(context)?._themeMode;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        elevation: 0.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.sentiment_satisfied_alt),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.email_outlined),
              label: ''),
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
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
}
