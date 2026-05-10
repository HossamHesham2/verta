import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:verta/features/auth/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  UserModel({required super.uId, required super.username, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uId: user.uid,
      username: user.displayName ?? '',
      email: user.email ?? '',
    );
  }
}
