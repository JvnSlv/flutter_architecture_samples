import 'package:flutter/material.dart';

import '../../app_extensions.dart';

class TodosListPage extends StatelessWidget {
  const TodosListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.featureTodosList.todosListAppBarTitle),
      ),
      body: Center(
        child: Text(context.l10n.featureTodosList.listOfTodos),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(context.designSystem.icons.plusSign),
        onPressed: () {},
      ),
    );
  }
}
