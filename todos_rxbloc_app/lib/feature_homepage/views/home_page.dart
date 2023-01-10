import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../../base/utils/constants.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  void _onTap(BuildContext context, int pageIndex) {
    context.read<HomeBlocType>().events.setPageIndex(pageIndex);
    switch (pageIndex) {
      case 0:
        context.go(TodoConstants.listRoute);
        break;
      case 1:
        context.go(TodoConstants.statsRoute);
        break;
    }
  }

  @override
  Widget build(BuildContext context) => RxBlocBuilder<HomeBlocType, int>(
        state: (bloc) => bloc.states.getPageIndex,
        builder: (context, snapshot, bloc) {
          int pageIndex = snapshot.data ?? 0;
          return Scaffold(
            body: child,
            bottomNavigationBar: RxBlocBuilder<HomeBlocType, int>(
              state: (bloc) => bloc.states.getPageIndex,
              builder: (context, snapshot, bloc) {
                return BottomNavigationBar(
                  currentIndex: pageIndex,
                  selectedItemColor: Theme.of(context).colorScheme.secondary,
                  onTap: (pageIndex) => _onTap(context, pageIndex),
                  iconSize: 25,
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(context.designSystem.icons.list),
                    ),
                    BottomNavigationBarItem(
                      label: 'Stats',
                      icon: Icon(context.designSystem.icons.trending),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
}
