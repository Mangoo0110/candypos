// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignoreforfile: publicmemberapidocs, sortconstructorsfirst

part of 'item.dart';

class Variant {
  final String id;
  final String itemId;
  final String variantName;
  final String itemName;

  late Reference _imageUrl;
  Reference get imageUrl => _imageUrl;

  final String? barcode;
  final String? sku;
  final double price;
  final double? productionCost;
  final Unit unitDetails;
  final double? stockCount;
  final double? stockAlertAt;

  final DateTime createdAt;
  final int index;

  Variant({
    required this.id,
    required this.itemId,
    required this.variantName,
    required this.itemName,
    required Reference? imageUrl,
    required this.barcode,
    required this.sku,
    required this.price,
    required this.productionCost,
    required this.unitDetails,
    required this.stockCount,
    required this.stockAlertAt,
    required this.createdAt,
    required this.index,
  }){
    dekhao("Setting imageUrl of item $itemName.");
    imageUrl ??= FirebaseStorage.instance.ref().child("items/images/$id");
    _imageUrl = imageUrl;
  }

  factory Variant.newItemVariant({
    required String itemId,
    required String itemName,
    required String variantId,
    required String variantName,
    required Unit unit,
  }) {
    return Variant(
        id: variantId,
        itemId: itemId,
        sku: null,
        barcode: null,
        itemName: itemName,
        imageUrl: null,
        variantName: variantName,
        price: 0,
        productionCost: null,
        unitDetails: unit,
        stockCount: null,
        stockAlertAt: 0,
        createdAt: DateTime.now(),
        index: DateTime.now().millisecondsSinceEpoch);
  }

  

  Variant copyWith({
    String? id,
    String? itemId,
    String? variantName,
    String? itemName,
    Reference? imageUrl,
    String? barcode,
    String? sku,
    double? price,
    double? productionCost,
    Unit? unitDetails,
    double? stockCount,
    double? stockAlertAt,
    DateTime? createdAt,
    int? index,
  }) {
    return Variant(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      variantName: variantName ?? this.variantName,
      itemName: itemName ?? this.itemName,
      imageUrl: imageUrl ?? _imageUrl,
      barcode: barcode ?? this.barcode,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      productionCost: productionCost ?? this.productionCost,
      unitDetails: unitDetails ?? this.unitDetails,
      stockCount: stockCount ?? this.stockCount,
      stockAlertAt: stockAlertAt ?? this.stockAlertAt,
      createdAt: createdAt ?? this.createdAt,
      index: index ?? this.index,
    );
  }

  @override
  String toString() {
    return 'Variant(id: $id, itemId: $itemId, variantName: $variantName, itemName: $itemName, _imageUrl: $_imageUrl, barcode: $barcode, sku: $sku, price: $price, productionCost: $productionCost, unitDetails: $unitDetails, stockCount: $stockCount, stockAlertAt: $stockAlertAt, createdAt: $createdAt, index: $index)';
  }

  @override
  bool operator ==(covariant Variant other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.itemId == itemId &&
      other.variantName == variantName &&
      other.itemName == itemName &&
      other._imageUrl == _imageUrl &&
      other.barcode == barcode &&
      other.sku == sku &&
      other.price == price &&
      other.productionCost == productionCost &&
      other.unitDetails == unitDetails &&
      other.stockCount == stockCount &&
      other.stockAlertAt == stockAlertAt &&
      other.createdAt == createdAt &&
      other.index == index;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      itemId.hashCode ^
      variantName.hashCode ^
      itemName.hashCode ^
      _imageUrl.hashCode ^
      barcode.hashCode ^
      sku.hashCode ^
      price.hashCode ^
      productionCost.hashCode ^
      unitDetails.hashCode ^
      stockCount.hashCode ^
      stockAlertAt.hashCode ^
      createdAt.hashCode ^
      index.hashCode;
  }
}
