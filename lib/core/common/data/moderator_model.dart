// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../domains/moderator.dart';

class ModeratorModel extends Moderator {

  ModeratorModel({
    required super.role,
    required super.userId,
    required super.addedBy,
    required super.addedAt,
  });

  ModeratorModel copyWith({
    String? role,
    String? userId,
    String? addedBy,
    DateTime? addedAt,
  }) {
    return ModeratorModel(
      role: role ?? this.role,
      userId: userId ?? this.userId,
      addedBy: addedBy ?? this.addedBy,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'userId': userId,
      'addedBy': addedBy,
      'addedAt': addedAt.toUtc().toIso8601String(),
    };
  }

  factory ModeratorModel.fromEntity(Moderator moderator) {
    return ModeratorModel(
      role: moderator.role,
      userId: moderator.userId,
      addedBy: moderator.addedBy,
      addedAt: moderator.addedAt,
    );
  }

  factory ModeratorModel.fromMap(Map<String, dynamic> map) {
    return ModeratorModel(
      role: map['role'] as String,
      userId: map['userId'] as String,
      addedBy: map['addedBy'] as String,
      addedAt: DateTime.parse(map['addedAt'] as String).toLocal(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModeratorModel.fromJson(String source) => ModeratorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ModeratorModel (role: $role, userId: $userId, addedBy: $addedBy, addedAt: $addedAt)';
  }

  @override
  bool operator ==(covariant ModeratorModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.role == role &&
      other.userId == userId &&
      other.addedBy == addedBy &&
      other.addedAt == addedAt;
  }

  @override
  int get hashCode {
    return role.hashCode ^
      userId.hashCode ^
      addedBy.hashCode ^
      addedAt.hashCode;
  }
}
