// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class ItemCategory {
  final String id;
  final String name;
  final Reference? imageUrl;
  final List<String> itemIds;

  ItemCategory({required this.id, required this.name, required this.imageUrl, required this.itemIds});

  ItemCategory copyWith({
    String? id,
    String? name,
    Reference? imageUrl,
    List<String>? itemIds,
  }) {
    return ItemCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      itemIds: itemIds ?? this.itemIds,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, imageUrl: $imageUrl, itemIds: $itemIds)';
  }

  @override
  bool operator ==(covariant ItemCategory other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      listEquals(other.itemIds, itemIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      itemIds.hashCode;
  }
}
