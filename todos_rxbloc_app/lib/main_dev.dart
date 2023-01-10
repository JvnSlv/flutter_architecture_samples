// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.


import 'base/app/config/environment_config.dart';
import 'base/app/initialization/app_setup.dart';
import 'base/app/todo_rxbloc.dart';

/// Main entry point for the development environment
void main() async => await setupAndRunApp(
  (config) => TodoRxbloc(
    config: config,
  ),
  environment: const EnvironmentConfig.development(),
);
