// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';

class ArchSampleTheme {
  static ThemeData get theme {
    final themeData = ThemeData.dark();
    final textTheme = themeData.textTheme;
    final body1 = textTheme.bodyText1?.copyWith(
      decorationColor: Colors.transparent,
    );

    return ThemeData.dark().copyWith(
      toggleableActiveColor: Colors.cyan[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: body1,
        actionTextColor: Colors.cyan[300],
      ),
      textTheme: textTheme.copyWith(
        bodyText1: body1,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.grey[800],
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.cyan[300],
        primary: Colors.grey[800],
      ),
    );
  }
}
