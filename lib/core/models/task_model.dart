import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel({
    required this.taskId,
    required this.taskTitle,
    required this.description,
    required this.date,
    required this.category,
    required this.priority,
    required this.isCompleted,
  });

  @HiveField(0)
  final String taskId;

  @HiveField(1)
  String taskTitle;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String category;

  @HiveField(5)
  String priority;

  @HiveField(6)
  bool isCompleted;

  factory TaskModel.create({
    required String taskTitle,
    required String description,
    DateTime? date,
    required String category,
    required String priority,
  }) => TaskModel(
    taskId: const Uuid().v1(),
    taskTitle: taskTitle,
    description: description,
    date: date ?? DateTime.now(),
    category: category,
    priority: priority,
    isCompleted: false,
  );
}
