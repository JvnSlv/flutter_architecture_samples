part of 'manage_todo_bloc.dart';

extension _ManageTodoExtension on Stream {
  Stream<NewTodoEnum> createTodo(
    Stream<String> setTitle,
    Stream<String> setDescription,
    NavigationBlocType navigationBloc,
    ManageTodoService manageService,
  ) =>
      withLatestFrom2<String, String, TextFieldsData>(
        setTitle,
        setDescription,
        (_, String title, String desc) =>
            TextFieldsData(title: title, description: desc),
      ).asResultStream().whereSuccess().switchMap((value) async* {
        if (value.title.isNotEmpty) {
          await manageService.createTodo(value.title, value.description).then(
            (value) {
              navigationBloc.events.navigate(
                const NavigationParams(
                  navigationEnum: NavigationEnum.pop,
                ),
              );
            },
          );
          yield Result.success(NewTodoEnum.newTodoSuccess);
        } else {
          yield Result.success(NewTodoEnum.newTodoError);
        }
      }).whereSuccess();

  Stream<NewTodoEnum> updateTodo(
    Stream<String> setTitle,
    Stream<String> setDescription,
    NavigationBlocType navigationBloc,
    TodoEntity? todo,
    CoordinatorBlocType coordinatorBloc,
    ManageTodoService manageService,
  ) =>
      withLatestFrom2<String, String, TextFieldsData>(
        setTitle,
        setDescription,
        (_, String title, String desc) =>
            TextFieldsData(title: title, description: desc),
      ).asResultStream().whereSuccess().switchMap((value) async* {
        if (value.title.isNotEmpty) {
          final newTodo = todo!.copyWith(
            note: value.description,
            task: value.title,
          );
          await manageService.updateTodo(newTodo).then((value) {
            navigationBloc.events.navigate(
              const NavigationParams(
                navigationEnum: NavigationEnum.pop,
              ),
            );
            coordinatorBloc.events.receiveUpdatedTodo(newTodo);
          });
          yield Result.success(NewTodoEnum.editTodoSuccess);
        } else {
          yield Result.success(NewTodoEnum.newTodoError);
        }
      }).whereSuccess();
}
