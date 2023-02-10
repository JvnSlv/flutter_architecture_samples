import 'package:todos_repository_core/todos_repository_core.dart';

// final List<TodoEntity> listOfTods = List<TodoEntity>.generate(
//   50,
//   (index) => TodoEntity(
//     id: index.toString(),
//     task: 'task:$index',
//     note: 'note:$index',
//     complete: false,
//   ),
// );
final List<TodoEntity> listOfTods = [
  TodoEntity(
    task: 'test 1',
    id: '1',
    note: 'note 1',
    complete: false,
  ),
  TodoEntity(
    task: 'test 2',
    id: '2',
    note: 'note 2',
    complete: true,
  ),
  TodoEntity(
    task: 'test 3',
    id: '3',
    note: 'note 3',
    complete: false,
  ),
  TodoEntity(
    task: 'test 4',
    id: '4',
    note: 'note 4',
    complete: true,
  ),
];
