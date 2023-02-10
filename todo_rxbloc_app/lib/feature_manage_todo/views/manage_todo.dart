import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:flutter_rx_bloc/rx_form.dart';
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
    super.initState();
  }

  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          _successToastMessages(context),
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
                            SizedBox(
                                height: context.designSystem.spacing.space25),
                            RxTextFormFieldBuilder<ManageTodoBlocType>(
                              cursorBehaviour:
                                  RxTextFormFieldCursorBehaviour.preserve,
                              state: (bloc) => bloc.states.validateTitle,
                              showErrorState: (bloc) => bloc.states.showErrors,
                              onChanged: (bloc, task) => bloc.events.setTitle(
                                task.trim(),
                              ),
                              builder: (fieldState) => TextFormField(
                                autofocus: widget.todo == null ? true : false,
                                controller: fieldState.controller,
                                decoration:
                                    fieldState.decoration.copyWithDecoration(
                                  InputDecoration(
                                    hintText: context.l10n.featureAddTodo.task,
                                  ),
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
    super.dispose();
  }

  Widget _successToastMessages(BuildContext context) =>
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
