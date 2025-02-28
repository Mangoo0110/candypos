import 'package:candypos/core/common/functions/formatting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domains/upload_meta.dart';

class UploadMetaModel extends UploadMeta{
  UploadMetaModel({required super.createdAt, required super.createdBy, required super.lastUpdatedBy, required super.lastUpdatedAt, required super.updateCount});

  factory UploadMetaModel.fromMap(Map<String, dynamic> map) {
    return UploadMetaModel(
      createdAt: parseDateTime(map['createdAt'])!,
      createdBy: map['createdBy'],
      lastUpdatedBy: map['lastUpdatedBy'],
      lastUpdatedAt: parseDateTime(map['lastUpdatedAt']),
      updateCount: map['updateCount'],
    );
  }

  factory UploadMetaModel.fromEntity(UploadMeta entity) {
    return UploadMetaModel(
      createdAt: entity.createdAt,
      createdBy: entity.createdBy,
      lastUpdatedBy: entity.lastUpdatedBy,
      lastUpdatedAt: entity.lastUpdatedAt,
      updateCount: entity.updateCount,
    );
  }

  Map<String, dynamic> toLocal() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'lastUpdatedBy': lastUpdatedBy,
      if(lastUpdatedAt != null) 'lastUpdatedAt': lastUpdatedAt?.toIso8601String(),
      'updateCount': updateCount,
    };
  }

  Map<String, dynamic> toRemote() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
      'lastUpdatedBy': lastUpdatedBy,
      if(lastUpdatedAt != null) 'lastUpdatedAt': Timestamp.fromDate(lastUpdatedAt!) ,
      'updateCount': FieldValue.increment(1),
    };
  }


}