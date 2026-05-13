part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeFailure extends HomeState {
  final String error;

  const HomeFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class TaskLoadedHomeState extends HomeState {
  final List<TaskModel> tasks;

  const TaskLoadedHomeState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class DeleteTaskState extends HomeState {
  @override
  List<Object> get props => [];
}

class UpdateTaskState extends HomeState {
  @override
  List<Object> get props => [];
}
