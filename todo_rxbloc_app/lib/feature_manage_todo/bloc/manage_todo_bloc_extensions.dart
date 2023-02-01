part of 'manage_todo_bloc.dart';

extension _ManageTodoExtension on Stream {
  Stream<NewTodoEnum> createTodo(
    TodoService todoService,
    Stream<String> setTitle,
    Stream<String> setDescription,
    Uuid uuid,
    NavigationBlocType navigationBloc,
    ManageTodoBloc bloc,
    TodoEntity? todo,
    CoordinatorBlocType coordinatorBloc,
  ) =>
      withLatestFrom2<String, String, TextFieldsData>(
        setTitle,
        setDescription,
        (_, String title, String desc) =>
            TextFieldsData(title: title, description: desc),
      )
          .switchMap((value) async* {
            if (value.title.isNotEmpty) {
              if (todo == null) {
                await todoService
                    .addTodo(
                      TodoEntity(
                        complete: false,
                        id: uuid.v1(),
                        task: value.title,
                        note: value.description,
                      ),
                    )
                    .whenComplete(
                      () => navigationBloc.events.navigate(
                        const NavigationParams(
                          navigationEnum: NavigationEnum.pop,
                        ),
                      ),
                    );
                yield Result.success(NewTodoEnum.newTodoSuccess);
              } else {
                final newTodo = todo.copyWith(
                  note: value.description,
                  task: value.title,
                );
                await todoService.updateTodo(newTodo).whenComplete(
                  () {
                    navigationBloc.events.navigate(
                      const NavigationParams(
                        navigationEnum: NavigationEnum.pop,
                      ),
                    );
                    coordinatorBloc.events.receiveUpdatedTodo(newTodo);
                  },
                );
                yield Result.success(NewTodoEnum.editTodoSuccess);
              }
            } else {
              yield Result.success(NewTodoEnum.newTodoError);
            }
          })
          .setResultStateHandler(bloc)
          .whereSuccess();
}
