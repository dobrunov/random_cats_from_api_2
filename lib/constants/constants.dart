import 'package:flutter/material.dart';

final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  textStyle:
      const TextStyle(fontFamily: 'Roboto', letterSpacing: 0.5, fontSize: 18),
  fixedSize: const Size(280, 40),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
);

const bgColor = Color(0xFFFBF5E4);

const timeStampTextStyle = TextStyle(
  color: Color(0xFF464646),
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto',
  letterSpacing: 0.4,
  fontSize: 14,
);

const catFactTextStyle = TextStyle(
  color: Color(0xFF464646),
  fontWeight: FontWeight.w500,
  fontFamily: 'Roboto',
  letterSpacing: 0.4,
  fontSize: 18,
);
