import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/core/helpers/hive_data_store.dart';
import 'task_event.dart';
import 'task_state.dart';
@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final HiveDataStore hiveDataStore;

  TaskBloc(this.hiveDataStore) : super(TaskInitial()) {
    on<AddTaskEvent>(_onAddTask);
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());

    try {
      await hiveDataStore.addTask(task: event.task);
      emit(TaskSuccess());
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }
}