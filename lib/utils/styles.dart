import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 16.0;

  static final Color _textColorStrong = Colors.black;
  static final Color _textColorDefault = Colors.grey;

  static const String _fontNameDefault = 'Muli';

  static final navbarTitle = TextStyle(
    fontFamily: _fontNameDefault,
  );

  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    color: _textColorStrong,
    fontSize: _textSizeLarge,
  );

  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    color: _textColorDefault,
    fontSize: _textSizeDefault,
  );
}
