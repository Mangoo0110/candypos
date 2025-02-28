import '../../domain/entities/unit.dart';

class UnitModel extends Unit {
  UnitModel({
    required super.shortName,
    required super.longName,
    required super.weightItem,
  });

  factory UnitModel.fromMap({required Map<String, dynamic> map}) {
    return UnitModel(
      shortName: map["shortName"] ?? 'na',
      longName: map["longName"] ?? 'NA',
      weightItem: map["weightItem"] ?? true,
    );
  }

  factory UnitModel.fromEntity(Unit unit) {
    return UnitModel(
      shortName: unit.shortName,
      longName: unit.longName,
      weightItem: unit.weightItem,
    );
  }

  // `toMap` method
  Map<String, dynamic> toMap() {
    return {
      "shortName": shortName,
      "longName": longName,
      "weightItem": weightItem,
    };
  }
}
