// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignoreforfile: publicmemberapidocs, sortconstructorsfirst, preferfinalfields

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/common/domains/upload_meta.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../../unit/domain/entities/unit.dart';

part 'variant.dart';

class Item {
  final String id;

  final String itemName;

  final String description;

  late Reference _imageUrl;
  Reference get imageUrl => _imageUrl;

  final Variant baseVariant;

  final Map<String, Variant> variants;

  final Unit unitDetails;

  final bool? visibleOnline;

  final Map<String, String> categoryIdMapName;

  final UploadMeta uploadDetails;

  final int index;

  final bool? deleted;

  Item({
    required this.id,
    required this.itemName,
    required this.description,
    required Reference? imageUrl,
    required this.baseVariant,
    required this.variants,
    required this.unitDetails,
    required this.visibleOnline,
    required this.categoryIdMapName,
    required this.uploadDetails,
    required this.index,
    required this.deleted,
  }) {
    imageUrl ??= FirebaseStorage.instance.ref().child("items/images/$id");
    _imageUrl = imageUrl;
  }


  Item copyWith({
    String? id,
    String? itemName,
    String? description,
    Reference? imageUrl,
    Variant? baseVariant,
    Map<String, Variant>? variants,
    Unit? unitDetails,
    bool? visibleOnline,
    Map<String, String>? categoryIdMapName,
    UploadMeta? uploadDetails,
    int? index,
    bool? deleted,
  }) {
    return Item(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? _imageUrl,
      baseVariant: baseVariant ?? this.baseVariant,
      variants: variants ?? this.variants,
      unitDetails: unitDetails ?? this.unitDetails,
      visibleOnline: visibleOnline ?? this.visibleOnline,
      categoryIdMapName: categoryIdMapName ?? this.categoryIdMapName,
      uploadDetails: uploadDetails ?? this.uploadDetails,
      index: index ?? this.index,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  String toString() {
    return 'Item(id: $id, itemName: $itemName, description: $description, _imageUrl: $_imageUrl, baseVariant: $baseVariant, variants: $variants, unitDetails: $unitDetails, visibleOnline: $visibleOnline, categoryIdMapName: $categoryIdMapName, uploadDetails: $uploadDetails, index: $index, deleted: $deleted)';
  }

  @override
  bool operator == (covariant Item other) {
    //if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.itemName == itemName &&
      other.description == description &&
      other._imageUrl == _imageUrl &&
      other.baseVariant == baseVariant &&
      mapEquals(other.variants, variants) &&
      other.unitDetails == unitDetails &&
      other.visibleOnline == visibleOnline &&
      mapEquals(other.categoryIdMapName, categoryIdMapName) &&
      other.uploadDetails == uploadDetails &&
      other.index == index &&
      other.deleted == deleted;
  }

  @override
  int get hashCode {
    return Object.hash(id, itemName, description, _imageUrl, baseVariant, variants, unitDetails, visibleOnline, categoryIdMapName, uploadDetails, index, deleted);
    return id.hashCode ^
      itemName.hashCode ^
      description.hashCode ^
      _imageUrl.hashCode ^
      baseVariant.hashCode ^
      variants.hashCode ^
      unitDetails.hashCode ^
      visibleOnline.hashCode ^
      categoryIdMapName.hashCode ^
      uploadDetails.hashCode ^
      index.hashCode ^
      deleted.hashCode;
  }
}
