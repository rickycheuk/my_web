import 'package:flutter/material.dart';
import 'package:my_web/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Center(child: Text("HomePage")),
    );
  }
}