// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:html/parser.dart' as parser;
// import 'package:http/http.dart' as http;
// import 'package:insta_public_api/insta_public_api.dart';
// import 'package:my_web/constants.dart';
//
// import '../utils/app_page_container.dart';
// import '../utils/button_widgets.dart';
//
// final _fireStore = FirebaseFirestore.instance;
//
// class InstagramPage extends StatefulWidget {
//   const InstagramPage({Key? key}) : super(key: key);
//
//   @override
//   _InstagramPageState createState() => _InstagramPageState();
// }
//
// Future<List<String>> loadPosts(String account) async {
//   final response = await http.get(
//     Uri.parse('https://cors-anywhere.herokuapp.com/https://www.instagram.com/${account}/?__d=dis'),
//     headers: {
//       "Access-Control-Allow-Origin": "*",
//       "Access-Control-Allow-Headers": "Origin, X-Requested-With",
//       "Access-Control-Allow-Methods": "POST, GET, OPTIONS, DELETE",
//       'User-Agent':
//           "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36",
//     },
//   );
//   debugPrint(response.body);
//   debugPrint('http++++++++++++++++++++++++++++++++++');
//   if (response.statusCode == 200) {
//     //Getting the html document from the response
//     try {
//       var data = json.decode(response.body);
//       var document = parser.parse(response.body);
//       // RegExp link = new RegExp(r'\<img alt=".* src=".*" style=');
//       // var linksList = link.allMatches(response.body).map((z) => z.group(0)).toList();
//
//       return [];
//     } catch (e) {
//       debugPrint('failed++++++++++++++++++++++++++++++++++');
//       return [];
//     }
//   } else {
//     return [];
//   }
// }
//
// class _InstagramPageState extends State<InstagramPage> {
//   TextEditingController emailController = TextEditingController();
//   final ipa = InstaPublicApi('username');
//
//   final account = 'mina_sr_my';
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final itemKey = GlobalKey();
//     return AppPageContainer(key: itemKey, children: [
//       plainTextButton(onPressed: () async {
//         showDialog(
//             // The user CANNOT close this dialog  by pressing outsite it
//             barrierDismissible: false,
//             context: context,
//             builder: (_) {
//               return Dialog(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       // The loading indicator
//                       CircularProgressIndicator(
//                         color: kPrimaryColor,
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       // Some text
//                       Text('loading...')
//                     ],
//                   ),
//                 ),
//               );
//             });
//
//         List<String> response = await loadPosts(account);
//
//         Navigator.pop(context);
//       })
//     ]);
//   }
// }
