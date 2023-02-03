import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../../base/enums/new_todo_enum.dart';
import '../bloc/manage_todo_bloc.dart';

class ManageTodoPage extends StatefulWidget {
  const ManageTodoPage({super.key, this.todo});
  final TodoEntity? todo;

  @override
  State<ManageTodoPage> createState() => _ManageTodoPageState();
}

class _ManageTodoPageState extends State<ManageTodoPage> {
  @override
  void initState() {
    noteController.text = widget.todo?.note ?? '';
    taskController.text = widget.todo?.task ?? '';
    super.initState();
  }

  final TextEditingController taskController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          _someToastMessage(context),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(context.l10n.featureAddTodo.addTodoAppBarTitle),
              ),
              body: RxBlocBuilder<ManageTodoBlocType, bool>(
                state: (bloc) => bloc.states.isLoading,
                builder: (context, snapshot, bloc) => snapshot.hasData
                    ? Padding(
                        padding: EdgeInsets.all(
                            context.designSystem.spacing.space16),
                        child: Column(
                          children: [
                            RxBlocBuilder<ManageTodoBlocType, String>(
                              state: (bloc) => bloc.states.validateTitle,
                              builder: (context, snapshot, bloc) =>
                                  TextFormField(
                                autofocus: true,
                                onChanged: (title) =>
                                    bloc.events.setTitle(title.trim()),
                                controller: taskController,
                                decoration: InputDecoration(
                                  errorText: (snapshot.data == '')
                                      ? context
                                          .l10n.featureAddTodo.todoTaskError
                                      : null,
                                  hintText: context.l10n.featureAddTodo.task,
                                ),
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            SizedBox(
                                height: context.designSystem.spacing.space25),
                            TextFormField(
                              onChanged: (description) => context
                                  .read<ManageTodoBlocType>()
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
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              floatingActionButton: FloatingActionButton(
                child: widget.todo != null
                    ? Icon(context.designSystem.icons.edit)
                    : Icon(context.designSystem.icons.plusSign),
                onPressed: () => widget.todo != null
                    ? context.read<ManageTodoBlocType>().events.updateTodo()
                    : context.read<ManageTodoBlocType>().events.saveTodo(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    taskController.dispose();
    super.dispose();
  }

  Widget _someToastMessage(BuildContext context) =>
      RxBlocListener<ManageTodoBlocType, NewTodoEnum>(
        state: (bloc) => bloc.states.newTodo,
        listener: (context, state) {
          switch (state) {
            case NewTodoEnum.newTodoSuccess:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.featureAddTodo.todoCreatedSuccess),
                  duration: const Duration(seconds: 1),
                ),
              );
              break;
            case NewTodoEnum.newTodoError:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n.featureAddTodo.todoCreatedError,
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
              break;
            case NewTodoEnum.editTodoSuccess:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n.featureAddTodo.todoEditSuccess,
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
              break;
          }
        },
      );
}
