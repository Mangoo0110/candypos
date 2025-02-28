import 'dart:convert';

import 'package:candypos/core/common/functions/formatting.dart';

import '../../domain/entities/store.dart';

class StoreRemoteDataFields {
  
  static String collection = "stores";
  static String id = "id";
  static String franchise = "franchise";
  static String imageUrl = "imageUrl";
  static String storeName = "storeName";
  static String address = "address";
  static String contactNo = "contactNo";
  static String createdAt = "createdAt";
  static String createdBy = "createdBy";

  StoreRemoteDataFields._();

  static StoreRemoteDataFields get instance {
    return StoreRemoteDataFields._();
  }
}

class StoreModel extends Store {

  StoreModel({
    required super.id,
    required super.franchise,
    required super.imageUrl,
    required super.storeName,
    required super.contactNo,
    required super.address,
    required super.createdAt,
    required super.createdBy,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] as String,
      franchise: map['franchise'],
      imageUrl: parseStorageReference(map['imageUrl'] as String),
      storeName: map['storeName'] ?? '',
      contactNo: map['contactNo'] ?? '',
      address: map['address'] ?? '',
      createdAt: parseDateTime(map['createdAt'] as dynamic)!,
      createdBy: map['createdBy'],
    );
  }


  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) => StoreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory StoreModel.fromEntity(Store store) {
    return StoreModel(
      id: store.id,
      franchise: store.franchise,
      imageUrl: store.imageUrl,
      storeName: store.storeName,
      contactNo: store.contactNo,
      address: store.address,
      createdAt: store.createdAt,
      createdBy: store.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'franchise': franchise,
      'imageUrl': imageUrl.fullPath,
      'storeName': storeName,
      'contactNo': contactNo,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy,
    };
  }
}
