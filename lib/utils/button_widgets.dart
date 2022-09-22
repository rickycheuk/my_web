import 'package:flutter/material.dart';

Widget plainTextButton(
    {Color textColor = Colors.white, double height = 20, String text = "Button", void Function()? onPressed}) {
  return TextButton(
      child: Container(
          height: height,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 13),
          )),
      style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0), side: BorderSide(color: textColor, width: 2)))),
      onPressed: onPressed);
}

Widget iconTextButton(
    {Color buttonColor = Colors.grey,
    Color textColor = Colors.white,
    IconData icon = Icons.mail_outline_rounded,
    double iconSize = 24,
    String text = "Button",
    double fontSize = 18,
    void Function()? onPressed}) {
  return Container(
      alignment: Alignment.center,
      child: Container(
          height: 60,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 3,
                offset: const Offset(1, 3), // changes position of shadow
              ),
            ],
          ),
          child: TextButton.icon(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: textColor,
              size: iconSize,
            ),
            label: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: fontSize)),
          )));
}
