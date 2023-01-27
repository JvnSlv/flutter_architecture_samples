part of 'add_todo_bloc.dart';

extension _AddTodoExtension on Stream {
  Stream<NewTodoEnum> createTodo(
    TodoService todoService,
    Stream<String> setTitle,
    Stream<String> setDescription,
    Uuid uuid,
    NavigationBlocType navigationBloc,
  ) =>
      withLatestFrom2<String, String, List<String>>(setTitle, setDescription,
              (_, String title, String desc) => [title, desc])
          .switchMap((value) async* {
        if (value[0].isNotEmpty) {
          await todoService.addTodo(TodoEntity(
              complete: false, id: uuid.v1(), note: value[1], task: value[0]));
          navigationBloc.events.navigate(const NavigationParametars(
            navigationEnum: NavigationEnum.pop,
          ));
          yield NewTodoEnum.newTodoSuccess;
        } else {
          yield NewTodoEnum.newTodoError;
        }
      });
}
