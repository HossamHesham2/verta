part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetAllTaskHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class IsCompletedEvent extends HomeEvent {
  final String taskId;

  const IsCompletedEvent(this.taskId);

  @override
  List<Object?> get props => [];
}

class DeleteTaskEvent extends HomeEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [];
}
class UpdateTaskEvent extends HomeEvent {
  final TaskModel taskModel;

  const UpdateTaskEvent(this.taskModel);

  @override
  List<Object?> get props => [];
}
