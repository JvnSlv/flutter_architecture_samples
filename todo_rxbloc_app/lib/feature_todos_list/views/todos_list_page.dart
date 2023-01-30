import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../bloc/todos_list_bloc.dart';
import '../bloc/todos_list_manage_bloc.dart';
import '../components/todo_list_tile.dart';

class TodosListPage extends StatelessWidget {
  const TodosListPage({super.key});

  @override
  Widget build(BuildContext context) => _buildDeleteToastMessage(
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.featureTodosList.todosListAppBarTitle),
          ),
          body: RxResultBuilder<TodosListBlocType, List<TodoEntity>>(
            state: (bloc) => bloc.states.todosList,
            buildError: (context, exception, bloc) => Center(
              child: Text(
                exception.toString(),
              ),
            ),
            buildLoading: (context, bloc) => const Center(
              child: CircularProgressIndicator(),
            ),
            buildSuccess: (context, snapshot, bloc) => ListView.builder(
              itemCount: snapshot.length,
              itemBuilder: (context, index) => TodoListTile(
                todoEntity: snapshot[index],
                onTap: () => bloc.events.navigateToPage(
                  NavigationParams(
                    navigationEnum: NavigationEnum.todoDetails,
                    extraParametars: snapshot[index],
                  ),
                ),
                onChanged: (_) => context
                    .read<TodosListManageBlocType>()
                    .events
                    .updateTodo(snapshot[index]),
                onDismissed: (direciton) =>
                    context.read<TodosListManageBlocType>().events.deleteTodo(
                          snapshot[index],
                        ),
              ),
            ),
          ),
          floatingActionButton:
              RxBlocBuilder<TodosListBlocType, NavigationParams>(
            state: (bloc) => bloc.states.navigate,
            builder: (context, snapshot, bloc) => FloatingActionButton(
              child: Icon(context.designSystem.icons.plusSign),
              onPressed: () => bloc.events.navigateToPage(
                const NavigationParams(navigationEnum: NavigationEnum.addTodo),
              ),
            ),
          ),
        ),
      );
}

Widget _buildDeleteToastMessage({required Widget child}) =>
    RxBlocListener<TodosListManageBlocType, TodoEntity>(
      state: (bloc) => bloc.states.todoDeleted,
      listener: (context, todo) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${todo.task}  ${context.l10n.featureTodosList.successDelete}'),
                GestureDetector(
                  onTap: () {
                    context
                        .read<TodosListManageBlocType>()
                        .events
                        .addTodo(todo);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  child: Text(context.l10n.featureTodosList.undo),
                )
              ],
            ),
          ),
        );
      },
      child: child,
    );
