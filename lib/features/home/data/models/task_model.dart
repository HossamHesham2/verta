import 'package:json_annotation/json_annotation.dart';
import 'package:verta/features/home/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends TaskEntity {
  TaskModel({
    required super.taskTitle,
    required super.description,
    required super.date,
    required super.category,
    required super.priority,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
