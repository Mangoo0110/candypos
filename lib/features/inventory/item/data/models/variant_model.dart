import 'package:candypos/core/common/functions/formatting.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../unit/data/models/unit_model.dart';
import '../../domain/entities/item.dart';

class VariantModel extends Variant {
  VariantModel({
    required super.id,
    required super.itemId,
    required super.sku,
    required super.barcode,
    required super.itemName,
    required super.variantName,
    required super.imageUrl,
    required super.price,
    required super.productionCost,
    required super.unitDetails,
    required super.stockCount,
    required super.stockAlertAt,
    required super.createdAt,
    required super.index,
  });

  factory VariantModel.fromMap(Map<String, dynamic> map) {

    Reference? urlRef;
    try {
       urlRef = FirebaseStorage.instance.ref(map['imageUrl'] as String);
    } catch (e) {
      "";
    }
    return VariantModel(
      id: map['id'],
      itemId: map['itemId'],
      sku: map['sku'],
      barcode: map['barcode'],
      itemName: map['itemName'],
      variantName: map['variantName'],
      imageUrl: urlRef,
      price: map['price'],
      productionCost: map['productionCost'],
      unitDetails: UnitModel.fromMap(map: map['unitDetails']),
      stockCount: map['stockCount'],
      stockAlertAt: map['stockAlertAt'],
      createdAt: parseDateTime(map['createdAt']) ?? DateTime.now(),
      index: map['index'],
    );
  }

  factory VariantModel.fromEntity(Variant entity) {
    return VariantModel(
      id: entity.id,
      itemId: entity.itemId,
      sku: entity.sku,
      barcode: entity.barcode,
      itemName: entity.itemName,
      variantName: entity.variantName,
      imageUrl: entity.imageUrl,
      price: entity.price,
      productionCost: entity.productionCost,
      unitDetails: entity.unitDetails,
      stockCount: entity.stockCount,
      stockAlertAt: entity.stockAlertAt,
      createdAt: entity.createdAt,
      index: entity.index,
    );
  }

  Map<String, dynamic> toRemote() {
    return {
      'id': id,
      'itemId': itemId,
      'sku': sku,
      'barcode': barcode,
      'itemName': itemName,
      'variantName': variantName,
      'imageUrl': imageUrl.fullPath,
      'price': price,
      'productionCost': productionCost,
      'unitDetails': UnitModel.fromEntity(unitDetails).toMap(),
      'stockCount': stockCount,
      'stockAlertAt': stockAlertAt,
      'createdAt': createdAt.toIso8601String(),
      'index': index,
    };
  }

  Map<String, dynamic> toLocal() {
    return {
      'id': id,
      'itemId': itemId,
      'sku': sku,
      'barcode': barcode,
      'itemName': itemName,
      'variantName': variantName,
      'imageUrl': imageUrl.fullPath,
      'price': price,
      'productionCost': productionCost,
      'unitDetails': UnitModel.fromEntity(unitDetails).toMap(),
      'stockCount': stockCount,
      'stockAlertAt': stockAlertAt,
      'createdAt': createdAt.toIso8601String(),
      'index': index,
    };
  }
}
