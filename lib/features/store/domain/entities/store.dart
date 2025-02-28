

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/utils/func/dekhao.dart';

class Store {
  final String id;
  final String? franchise;
  final String storeName;
  final String contactNo;
  late Reference _imageUrl;
  final String address;
  
  /// This field [createdAt] is the time and date data when this particular store location was first time created.
  /// 
  /// **Should not be changed.**
  final DateTime createdAt;
  final String createdBy;

  Store({
    required this.id,
    required this.franchise, 
    required Reference? imageUrl,
    required this.storeName, 
    required this.contactNo,
    required this.address, 
    required this.createdAt,
    required this.createdBy,
    }){
      dekhao("Setting imageUrl of store entity");
      imageUrl ??= FirebaseStorage.instance.ref().child("stores/images/$id");
      _imageUrl = imageUrl;
    }

  Reference get imageUrl => _imageUrl;


  @override
  String toString() {
    return 'Store(id: $id, franchise: $franchise, name: $storeName, contactNo: $contactNo, imageUrl: ${imageUrl?.fullPath}, address: $address, createdAt: $createdAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(covariant Store other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.franchise == franchise &&
      other.storeName == storeName &&
      other.contactNo == contactNo &&
      other.imageUrl == imageUrl &&
      other.address == address &&
      other.createdBy == createdBy && 
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      franchise.hashCode ^
      storeName.hashCode ^
      contactNo.hashCode ^
      imageUrl.hashCode ^
      address.hashCode ^
      createdAt.hashCode ^
      createdBy.hashCode;
  }

  Store copyWith({
    String? id,
    String? franchise,
    String? storeName,
    String? contactNo,
    Reference? imageUrl,
    String? address,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return Store(
      id: id ?? this.id,
      franchise: franchise ?? this.franchise,
      storeName: storeName ?? this.storeName,
      contactNo: contactNo ?? this.contactNo,
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
