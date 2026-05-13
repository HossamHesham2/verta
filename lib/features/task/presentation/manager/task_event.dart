import 'package:equatable/equatable.dart';
import 'package:verta/core/models/task_model.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;

  AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}