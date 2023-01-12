// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';

import './design_system.dart';
import './design_system/design_system_colors.dart';

class TodoRxblocTheme {
  static ThemeData buildTheme(DesignSystem designSystem) {
    final ThemeData baseTheme;
    final designSystemColor = designSystem.colors;

    baseTheme = ArchSampleTheme.theme;

    const fontName = 'WorkSans';

    return baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(fontFamily: fontName),
      primaryTextTheme: baseTheme.primaryTextTheme.apply(fontFamily: fontName),
      iconTheme: _buildIconTheme(baseTheme.iconTheme, designSystemColor),
      extensions: <ThemeExtension<dynamic>>[designSystem],
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.cyan[100],
      ),
      // Override any material widget themes here if needed.
    );
  }

  static IconThemeData _buildIconTheme(
          IconThemeData base, DesignSystemColors designSystemColors) =>
      base.copyWith(
        color: designSystemColors.primaryColor,
      );
}
