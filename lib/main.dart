import 'package:animated_background/animated_background.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_web/pages/all_pages.dart';
import 'package:my_web/theme.dart';
import 'package:my_web/utils/my_web_icons.dart';
import 'package:my_web/utils/preload_image.dart';

import 'constants.dart';
import 'firebase_options.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.icon = Icons.web,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  IconData icon;
  bool isExpanded;
}

// final _fireStore = FirebaseFirestore.instance;
FirebaseAnalytics analytics = FirebaseAnalytics.instance;

const profileId = 'Tiqrj06AHigcHiytJPf1';
String webTitle = 'Ricky Cheuk';
String description = '- Software Engineer -';
String userName = 'Ricky Cheuk';
String userId = '';

List preloadImages = [
  "assets/images/ricky.jpg",
  "assets/images/one.png",
  "assets/images/two.png",
  "assets/images/three.png",
  "assets/images/four.png",
  "assets/images/five.png",
  "assets/images/six.png"
];

var _brightness = SchedulerBinding.instance.window.platformBrightness;
bool isDarkMode = _brightness == Brightness.dark;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  for (var img in preloadImages) {
    await loadImage(AssetImage(img));
  }
  // Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  userId = userCredential.user?.uid as String;
  await FirebaseAnalytics.instance.logEvent(
    name: "id",
    parameters: {
      "userId": userId,
    },
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark; //isDarkMode ? ThemeMode.dark : ThemeMode.light;

  @override
  void initState() {
    super.initState();
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
}

class Page extends StatefulWidget {
  const Page({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // init pages
    Widget homePage = HomePage(userName: userName, description: description, links: const [
      'https://www.linkedin.com/in/rickycheuk/',
      'https://github.com/rickycheuk',
      'https://www.instagram.com/thlipperythnake/?hl=en'
    ], websiteNames: const [
      'Linkedin',
      'GitHub',
      'Instagram'
    ], icons: const [
      My_web.linkedin_1,
      My_web.github_1,
      My_web.instagram_1
    ],
    userId: userId);

    // Defining particles for animated background
    ParticleOptions particles = const ParticleOptions(
      baseColor: Colors.white,
      spawnOpacity: 0.0,
      opacityChangeRate: 0.69,
      minOpacity: 0.069,
      maxOpacity: 0.420,
      particleCount: 69,
      spawnMaxRadius: 5.0,
      spawnMaxSpeed: 69.0,
      spawnMinSpeed: 11,
      spawnMinRadius: 2.0,
    );

    return GestureDetector(
        onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: _buildAppBar(),
          body: AnimatedBackground(
            vsync: this,
            behaviour: RandomParticleBehaviour(options: particles),
            child:
            Container(alignment: Alignment.center, child: homePage),
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
              title: Text(
                widget.title,
                style: const TextStyle(color: kContentColorDarkTheme),
              ),
              // centerTitle: true,
              elevation: 0.0,
              bottomOpacity: 0.5,
              actions: [
                IconButton(
                  icon: Icon(_themeMode == ThemeMode.light ? Icons.dark_mode : Icons.wb_sunny_outlined,
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
