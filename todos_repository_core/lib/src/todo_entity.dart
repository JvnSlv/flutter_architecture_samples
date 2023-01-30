import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class TodoEntity {
  final String id;
  final String task;
  final String note;
  final bool complete;

  TodoEntity({
    required this.id,
    required this.task,
    required this.note,
    required this.complete,
  });

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          task == other.task &&
          note == other.note &&
          complete == other.complete;

  Map<String, Object> toJson() {
    return {
      'id': id,
      'task': task,
      'note': note,
      'complete': complete,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{id: $id, task: $task, note: $note, complete: $complete, }';
  }

  static TodoEntity fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'] as String,
      task: json['task'] as String,
      note: json['note'] as String,
      complete: json['complete'] as bool,
    );
  }

  TodoEntity copyWith({
    String? id,
    String? task,
    String? note,
    bool? complete,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      task: task ?? this.task,
      note: note ?? this.note,
      complete: complete ?? this.complete,
    );
  }
}
