import 'package:flutter/material.dart';

/// COLOR
const bgColor = Color(0xFFFBF5E4);
const catFactsTileColor = Color(0xFFF5ABC4);
const deleteFactColor = Colors.pink;
const textColor = Color(0xFF464646);
const buttonTextColor = Color(0xFFFFFFFF);

/// BUTTON STYLE
final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  textStyle: const TextStyle(
    color: buttonTextColor,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 18,
  ),
  fixedSize: const Size(280, 40),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

/// TEXT STYLE
const timeStampTextStyle = TextStyle(
  color: textColor,
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto',
  letterSpacing: 0.4,
  fontSize: 14,
);

const catFactTextStyle = TextStyle(
  color: textColor,
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto',
  letterSpacing: 0.4,
  fontSize: 18,
);

/// GAPS
const sizedBoxHeight10 = SizedBox(height: 10);
const sizedBoxHeight25 = SizedBox(height: 25);

/// PADDINGS
const paddingsAll8 = EdgeInsets.all(8.0);
const paddingsAll24 = EdgeInsets.all(24);
const paddingsLeftRightTop25 = EdgeInsets.only(left: 25.0, right: 25, top: 25);
