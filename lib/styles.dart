import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 16.0;

  static final Color _textColorStrong = Colors.black;
  static final Color _textColorDefault = Colors.black;

  //static const String _fontNameDefault = 'Muli';

  static const navbarTitle = TextStyle(
      //fontFamily: _fontNameDefault,
      );

  static final headerLarge = TextStyle(
    //fontFamily: _fontNameDefault,
    color: _textColorStrong,
    fontSize: _textSizeLarge,
  );

  static final textDefault = TextStyle(
    //fontFamily: _fontNameDefault,
    color: _textColorDefault,
    fontSize: _textSizeDefault,
  );

  //static Color _hexToColor(String code) {
  //return Color(int.parse(code.substring(0, 6), radix: 16 + 0xF000000));
  //}
}
