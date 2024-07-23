import 'package:flutter/material.dart';

/// [NkGetXFontStyle] USE CUSTOM FONT

class NkGetXFontStyle {
  static const primaryCustomFontStyle = "Helvetica";

  static TextTheme primaryTextTheme(BuildContext context) =>
      Theme.of(context).textTheme.apply(
            fontFamily: primaryCustomFontStyle,
          );
}
