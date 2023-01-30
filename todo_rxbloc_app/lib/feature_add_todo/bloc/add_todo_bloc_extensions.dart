part of 'add_todo_bloc.dart';

extension _AddTodoExtension on Stream {
  Stream<NewTodoEnum> createTodo(
    TodoService todoService,
    Stream<String> setTitle,
    Stream<String> setDescription,
    Uuid uuid,
    NavigationBlocType navigationBloc,
    AddTodoBloc bloc,
  ) =>
      withLatestFrom2<String, String, TextFieldsData>(
        setTitle,
        setDescription,
        (_, String title, String desc) =>
            TextFieldsData(title: title, description: desc),
      )
          .switchMap((value) async* {
            if (value.title.isNotEmpty) {
              await todoService.addTodo(
                TodoEntity(
                  complete: false,
                  id: uuid.v1(),
                  task: value.title,
                  note: value.description,
                ),
              );
              navigationBloc.events.navigate(const NavigationParametars(
                navigationEnum: NavigationEnum.pop,
              ));
              yield Result.success(NewTodoEnum.newTodoSuccess);
            } else {
              yield Result.success(NewTodoEnum.newTodoError);
            }
          })
          .setResultStateHandler(bloc)
          .whereSuccess();
}
