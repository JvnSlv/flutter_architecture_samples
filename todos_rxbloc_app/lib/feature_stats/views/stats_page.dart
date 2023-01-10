import 'package:flutter/material.dart';

import '../../app_extensions.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.featureStats.statsAppBarTitle),
      ),
      body: Center(
        child: Text(context.l10n.featureStats.stats),
      ),
    );
  }
}
