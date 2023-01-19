import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../../base/enums/new_todo_enum.dart';
import '../bloc/add_todo_bloc.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.featureAddTodo.addTodoAppBarTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              RxBlocBuilder<AddTodoBlocType, String>(
                state: (bloc) => bloc.states.validateTitle,
                builder: (context, snapshot, bloc) => TextFormField(
                  autofocus: true,
                  onChanged: (title) => context
                      .read<AddTodoBlocType>()
                      .events
                      .setTitle(title.trim()),
                  controller: taskController,
                  decoration: InputDecoration(
                    errorText:
                        snapshot.data == context.l10n.featureAddTodo.emptyText
                            ? context.l10n.featureAddTodo.todoTaskError
                            : null,
                    hintText: context.l10n.featureAddTodo.task,
                  ),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                onChanged: (description) => context
                    .read<AddTodoBlocType>()
                    .events
                    .setDescription(description.trim()),
                controller: noteController,
                decoration: InputDecoration(
                  hintText: context.l10n.featureAddTodo.note,
                ),
                maxLines: 10,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
        floatingActionButton: RxBlocListener<AddTodoBlocType, NewTodoEnum>(
          state: (bloc) => bloc.states.newTodo,
          listener: (context, state) {
            if (state == NewTodoEnum.newTodoSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.featureAddTodo.todoCreatedSuccess),
                ),
              );
            } else if (state == NewTodoEnum.newTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                context.l10n.featureAddTodo.todoCreatedError,
              )));
            }
          },
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<AddTodoBlocType>().events.saveTodo(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    taskController.dispose();
    super.dispose();
  }
}
