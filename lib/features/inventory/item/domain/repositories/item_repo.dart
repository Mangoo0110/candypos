import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/api_handler/success.dart';
import '../../../../../core/common/domains/upload_meta.dart';
import '../entities/item.dart';

class UpdateItemParams {
  final String id;

  final String? barcode;

  final String? sku;

  final String? itemName;

  final String? description;

  final String? imageUrl;

  final Variant? baseVariant;

  final Map<String, Variant> updatingVariants;

  final Unit? unitDetails;

  final bool? visibleOnline;

  final Map<String, String>? categoryIdMapName;

  final UploadMeta uploadDetails;

  final int? index;

  UpdateItemParams({
    required this.id,
    this.barcode,
    this.sku,
    this.itemName,
    this.description,
    this.imageUrl,
    this.baseVariant,
    required this.updatingVariants,
    this.unitDetails,
    this.visibleOnline,
    this.categoryIdMapName,
    required this.uploadDetails,
    this.index,
  });
}

class UpdateVariantParams {
  final String itemId;
  final String variantId;
  final String? itemName;
  final String? variantName;
  final String? imageUrl;
  final String? barcode;
  final String? sku;
  final double? price;
  final double? productionCost;
  final double? stockCount;
  final double? stockAlertAt;
  final int? index;

  UpdateVariantParams({
    required this.itemId,
    required this.variantId,
    this.variantName,
    required this.imageUrl,
    this.barcode,
    this.sku,
    this.price,
    this.productionCost,
    this.itemName,
    this.stockCount,
    this.stockAlertAt,
    this.index,
  });
}




abstract interface class ItemRepo {

  Future<Either<DataCRUDFailure, Success>> createItem({required Item item, required Uint8List? image});

  Future<Either<DataCRUDFailure, Success>> updateItem({required Item? item, required Uint8List? image, required Reference reference});

  Future<Either<DataCRUDFailure, Success>> deleteItem({required String itemId});

  Either<DataCRUDFailure, Stream<List<Item>>> fetchItems();

}


