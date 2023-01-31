// Copyright (c) 2022, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:rx_bloc/rx_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_repository_core/todos_repository_core.dart';

part 'coordinator_bloc.rxb.g.dart';
part 'coordinator_bloc_extensions.dart';

abstract class CoordinatorEvents {
  void deleteTodo(TodoEntity todo);
}

abstract class CoordinatorStates {
  Stream<TodoEntity> get deletedTodo;
}

/// The coordinator bloc manages the communication between blocs.
///
/// The goals is to keep all blocs decoupled from each other
/// as the entire communication flow goes through this bloc.
@RxBloc()
class CoordinatorBloc extends $CoordinatorBloc {
  @override
  Stream<TodoEntity> _mapToDeletedTodoState() => _$deleteTodoEvent;
}
