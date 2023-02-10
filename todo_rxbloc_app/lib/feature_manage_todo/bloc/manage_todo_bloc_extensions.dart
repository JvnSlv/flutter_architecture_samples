part of 'manage_todo_bloc.dart';

extension _ManageTodoExtension on Stream {
  Stream<Result<NewTodoEnum>> createTodo(
    Stream<String> setTitle,
    Stream<String> setDescription,
    ManageTodoService manageService,
  ) =>
      withLatestFrom2<String, String, TextFieldsData>(
        setTitle,
        setDescription,
        (_, String title, String desc) =>
            TextFieldsData(title: title, description: desc),
      ).asResultStream().whereSuccess().switchMap(
            (value) => manageService
                .createTodo(value.title, value.description)
                .then((value) => NewTodoEnum.newTodoSuccess)
                .asResultStream(),
          );

  Stream<Result<NewTodoEnum>> updateTodo(
    Stream<String> setTitle,
    Stream<String> setDescription,
    TodoEntity? todo,
    ManageTodoService manageService,
    CoordinatorBlocType coordinatorBloc,
  ) =>
      withLatestFrom2<String, String, TextFieldsData>(
        setTitle,
        setDescription,
        (_, String title, String desc) =>
            TextFieldsData(title: title, description: desc),
      ).asResultStream().whereSuccess().switchMap((value) => manageService
              .updateTodo(
                  todo!.copyWith(note: value.description, task: value.title))
              .then((value) {
            coordinatorBloc.events.receiveUpdatedTodo(value);
            return NewTodoEnum.editTodoSuccess;
          }).asResultStream());
}
