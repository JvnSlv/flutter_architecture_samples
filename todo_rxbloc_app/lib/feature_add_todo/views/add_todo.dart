import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';

import '../../app_extensions.dart';
import '../bloc/add_todo_bloc.dart';
import '../components/add_todo_toast_message.dart';

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
          padding: EdgeInsets.all(context.designSystem.spacing.space16),
          child: Column(
            children: [
              RxBlocBuilder<AddTodoBlocType, String>(
                state: (bloc) => bloc.states.validateTitle,
                builder: (context, snapshot, bloc) => TextFormField(
                  autofocus: true,
                  onChanged: (title) => bloc.events.setTitle(title.trim()),
                  controller: taskController,
                  decoration: InputDecoration(
                    errorText: (snapshot.data == '')
                        ? context.l10n.featureAddTodo.todoTaskError
                        : null,
                    hintText: context.l10n.featureAddTodo.task,
                  ),
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(height: context.designSystem.spacing.space25),
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
        floatingActionButton: AddTodoToastMessage(
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
