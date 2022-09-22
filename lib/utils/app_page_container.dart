import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';

const double padding = 10.0;

class AppPageContainer extends StatelessWidget {
  const AppPageContainer({required Key key, this.children = const <Widget>[]}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyText1?.color as Color;
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: padding, right: padding, bottom: padding),
            alignment: Alignment.center,
            color: Colors.transparent,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: min(MediaQuery.of(context).size.width, 500),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        color: textColor == kContentColorDarkTheme
                            ? Colors.black.withOpacity(0.420)
                            : Colors.white.withOpacity(0.420),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(1, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(children: children))
                ])));
  }
}
