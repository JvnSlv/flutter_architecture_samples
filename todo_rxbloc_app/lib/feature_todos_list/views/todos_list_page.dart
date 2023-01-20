import 'package:flutter/material.dart';
import 'package:flutter_rx_bloc/flutter_rx_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

import '../../app_extensions.dart';
import '../../base/enums/current_page_enum.dart';
import '../../base/models/navigation_parametars.dart';
import '../bloc/todos_list_bloc.dart';
import '../components/delete_success_toast.dart';
import '../components/todo_list_tile.dart';

class TodosListPage extends StatelessWidget {
  const TodosListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RxBlocListener<TodosListBlocType, NavigationParametars>(
      state: (bloc) => bloc.states.navigate,
      listener: (context, state) => state,
      child: DeleteSuccessToast(
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
                onTap: () => bloc.events.navigateToPage(NavigationParametars(
                  navigationEnum: NavigationEnum.todoDetails,
                  extraParametars: snapshot[index],
                )),
                onChanged: (_) => bloc.events.updateTodo(snapshot[index]),
                onDismissed: (direciton) => bloc.events.deleteTodo(
                  snapshot[index],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(context.designSystem.icons.plusSign),
            onPressed: () => context
                .read<TodosListBlocType>()
                .events
                .navigateToPage(const NavigationParametars(
                    navigationEnum: NavigationEnum.addTodo)),
          ),
        ),
      ),
    );
  }
}
