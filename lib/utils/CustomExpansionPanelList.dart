import 'dart:math';

import 'package:flutter/material.dart';

const double _kPanelHeaderCollapsedHeight = 60.0;
const double _kPanelHeaderExpandedHeight = 76.0;

class CustomExpansionPanelList extends StatelessWidget {
  const CustomExpansionPanelList(
      {required Key key,
      this.children = const <ExpansionPanel>[],
      required this.expansionCallback,
      required this.color,
      required this.radius,
      required this.screenWidth,
      this.animationDuration = kThemeAnimationDuration})
      : super(key: key);

  final Color color;

  final double radius;

  final double screenWidth;
  final List<ExpansionPanel> children;

  final ExpansionPanelCallback expansionCallback;

  final Duration animationDuration;

  bool _isChildExpanded(int index) {
    return children[index].isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = <Widget>[];
    const EdgeInsets kExpandedEdgeInsets =
        EdgeInsets.symmetric(vertical: _kPanelHeaderExpandedHeight - _kPanelHeaderCollapsedHeight);

    for (int index = 0; index < children.length; index += 1) {
      final Row header = Row(
        children: <Widget>[
          Expanded(
            child: AnimatedContainer(
              duration: animationDuration,
              curve: Curves.fastOutSlowIn,
              margin: _isChildExpanded(index) ? kExpandedEdgeInsets : EdgeInsets.zero,
              child: SizedBox(
                height: _kPanelHeaderCollapsedHeight,
                child: Container(
                    alignment: Alignment.center,
                    child: children[index].headerBuilder(
                      context,
                      children[index].isExpanded,
                    )),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(end: 8.0),
            child: ExpandIcon(
              isExpanded: _isChildExpanded(index),
              padding: const EdgeInsets.all(16.0),
              onPressed: (bool isExpanded) {
                expansionCallback(index, isExpanded);
              },
            ),
          ),
        ],
      );

      items.add(InkWell(
        onTap: () {
          expansionCallback(index, _isChildExpanded(index));
        }, // Handle your callback
        child: Ink(
          width: min(screenWidth, 500),
          key: _SaltedKey<BuildContext, int>(context, index * 2),
          child: Material(
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            color: color,
            child: Column(
              children: <Widget>[
                header,
                AnimatedCrossFade(
                  firstChild: Container(height: 0.0),
                  secondChild: children[index].body,
                  firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                  secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: _isChildExpanded(index) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: animationDuration,
                ),
              ],
            ),
          ),
        ),
      ));
      items.add(Divider(
        key: _SaltedKey<BuildContext, int>(context, index * 2 + 1),
        height: 15.0,
        color: Colors.transparent,
      ));
    }

    return Column(
      children: items,
    );
  }
}

class _SaltedKey<S, V> extends LocalKey {
  const _SaltedKey(this.salt, this.value);

  final S salt;
  final V value;

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final _SaltedKey<S, V> typedOther = other;
    return salt == typedOther.salt && value == typedOther.value;
  }

  @override
  int get hashCode => hashValues(runtimeType, salt, value);

  @override
  String toString() {
    final String saltString = S == String ? '<\'$salt\'>' : '<$salt>';
    final String valueString = V == String ? '<\'$value\'>' : '<$value>';
    return '[$saltString $valueString]';
  }
}
