import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../blocs/todo_details_bloc.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage({super.key, required this.todo, required this.id});
  final TodoEntity todo;
  final String id;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(context.l10n.featureTodoDetails.todoDetailsAppBarTitle),
          actions: [
            RxBlocBuilder<TodoDetailsBlocType, TodoEntity>(
              state: (bloc) => bloc.states.todoEntity,
              builder: (context, snapshot, bloc) => IconButton(
                icon: Icon(context.designSystem.icons.delete),
                onPressed: () => context
                    .read<TodoDetailsBlocType>()
                    .events
                    .deleteTodo(snapshot.data ?? todo),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(context.designSystem.spacing.space16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: context.designSystem.spacing.space8),
                child: RxBlocBuilder<TodoDetailsBlocType, TodoEntity>(
                  state: (bloc) => bloc.states.todoEntity,
                  builder: (context, snapshot, bloc) => Checkbox(
                    value: snapshot.data?.complete ?? todo.complete,
                    onChanged: (value) {
                      bloc.events.toggleTodo(todo, value!);
                    },
                  ),
                ),
              ),
              Expanded(
                child: RxBlocBuilder<TodoDetailsBlocType, TodoEntity>(
                  state: (bloc) => bloc.states.todoEntity,
                  builder: (context, snapshot, bloc) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.designSystem.spacing.space8,
                          bottom: context.designSystem.spacing.space16,
                        ),
                        child: Text(
                          snapshot.data?.task ?? todo.task,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Text(
                        snapshot.data?.note ?? todo.note,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<TodoDetailsBlocType>().events.navigate(
                NavigationParams(
                  navigationEnum: NavigationEnum.addTodo,
                  extraParametars: todo,
                ),
              ),
          child: Icon(context.designSystem.icons.edit),
        ),
      );
}
