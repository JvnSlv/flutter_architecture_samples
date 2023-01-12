// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.


import 'package:flutter/material.dart';

@immutable
class DesignSystemImages {
  const DesignSystemImages();

  static const imagePath = 'assets/images';

  final testImage = const AssetImage('$imagePath/testImage.png');
}
