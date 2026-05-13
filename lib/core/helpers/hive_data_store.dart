import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:verta/core/models/task_model.dart';

@injectable
class HiveDataStore {
  static const String boxName = "TaskModelsBox";

  Box<TaskModel> get _box => Hive.box<TaskModel>(boxName);

  /// Add Task
  Future<void> addTask({required TaskModel task}) async {
    await _box.put(task.taskId, task);
  }

  /// Get All Tasks
  List<TaskModel> getTasks() {
    return _box.values.toList();
  }

  /// Get Task
  TaskModel? getTask({required String id}) {
    return _box.get(id);
  }

  /// Update Task
  Future<void> updateTask({required TaskModel task}) async {
    await _box.put(task.taskId, task);
  }

  /// Delete Task
  Future<void> deleteTask({required String id}) async {
    await _box.delete(id);
  }

  /// Listen to Box
  ValueListenable<Box<TaskModel>> listenToTasks() {
    return _box.listenable();
  }
}
