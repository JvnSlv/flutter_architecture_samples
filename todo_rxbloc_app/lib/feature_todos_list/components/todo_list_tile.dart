import 'package:flutter/material.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile(
      {super.key,
      required this.todoEntity,
      this.onDismissed,
      this.onChanged,
      this.onTap});
  final TodoEntity todoEntity;
  final Function(DismissDirection)? onDismissed;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => Dismissible(
        onDismissed: onDismissed,
        key: ValueKey(todoEntity.id),
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            value: todoEntity.complete,
            onChanged: onChanged,
          ),
          title: Text(
            todoEntity.task,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            todoEntity.note,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      );
}
