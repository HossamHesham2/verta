import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/core/errors/exceptions.dart';
import 'package:verta/core/helpers/hive_data_store.dart';
import 'package:verta/core/models/task_model.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HiveDataStore hiveDataStore;

  HomeBloc(this.hiveDataStore) : super(HomeInitial()) {
    on<GetAllTaskHomeEvent>(_getTasks);
    on<IsCompletedEvent>(_isCompleted);
    on<DeleteTaskEvent>(_deleteTask);
    on<UpdateTaskEvent>(_updateTask);
  }

  Future<void> _getTasks(
    GetAllTaskHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    try {
      final tasks = hiveDataStore.getTasks();
      emit(TaskLoadedHomeState(tasks));
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }

  Future<void> _isCompleted(
    IsCompletedEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    try {
      final tasks = hiveDataStore.getTasks().toList();

      final index = tasks.indexWhere((task) => task.taskId == event.taskId);

      if (index == -1) {
        emit(const HomeFailure(error: "Task not found"));
        return;
      }

      tasks[index].isCompleted = true;

      await tasks[index].save();

      emit(HomeSuccessState());

      emit(TaskLoadedHomeState(hiveDataStore.getTasks()));
    } on AppException catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }

  Future<void> _deleteTask(
    DeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final tasks = hiveDataStore.getTasks().toList();

      final index = tasks.indexWhere((task) => task.taskId == event.taskId);
      if (index == -1) {
        emit(const HomeFailure(error: "Task not found"));
        return;
      }
      await tasks[index].delete();
      emit(DeleteTaskState());
      emit(TaskLoadedHomeState(hiveDataStore.getTasks()));
    } on AppException catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }

  Future<void> _updateTask(
    UpdateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final tasks = hiveDataStore.getTasks().toList();

      final index = tasks.indexWhere((task) => task.taskId == event.taskModel.taskId);
      if (index == -1) {
        emit(const HomeFailure(error: "Task not found"));
        return;
      }
      tasks[index].taskTitle = event.taskModel.taskTitle;
      tasks[index].description = event.taskModel.description;
      tasks[index].date = event.taskModel.date;
      tasks[index].category = event.taskModel.category;
      tasks[index].priority = event.taskModel.priority;
      tasks[index].isCompleted = event.taskModel.isCompleted;

      await tasks[index].save();
      emit(UpdateTaskState());
      emit(TaskLoadedHomeState(hiveDataStore.getTasks()));
    } on AppException catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }
}
