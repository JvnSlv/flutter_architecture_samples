import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parameters.dart';
import '../bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  void _onTap(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        context.read<NavigationBlocType>().events.navigate(
              const NavigationParams(navigationEnum: NavigationEnum.list),
            );
        break;
      case 1:
        context.read<NavigationBlocType>().events.navigate(
              const NavigationParams(navigationEnum: NavigationEnum.stats),
            );
        break;
    }
  }

  @override
  Widget build(BuildContext context) =>
      RxBlocBuilder<NavigationBlocType, NavigationParams>(
        state: (bloc) => bloc.states.getPageIndex,
        builder: (context, snapshot, bloc) => Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: (snapshot.hasData
                    ? snapshot.data!.navigationEnum.index > 1
                        ? NavigationEnum.list
                        : snapshot.data!.navigationEnum
                    : NavigationEnum.list)
                .index,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            onTap: (pageIndex) => _onTap(context, pageIndex),
            iconSize: context.designSystem.typography.navIconSize,
            items: [
              BottomNavigationBarItem(
                label: context.l10n.todoList,
                icon: Icon(context.designSystem.icons.list),
              ),
              BottomNavigationBarItem(
                label: context.l10n.stats,
                icon: Icon(context.designSystem.icons.trending),
              ),
            ],
          ),
        ),
      );
}
