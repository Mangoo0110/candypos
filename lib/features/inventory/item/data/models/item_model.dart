import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/common/data/upload_meta_model.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../../unit/data/models/unit_model.dart';
import 'variant_model.dart';
import '../../domain/entities/item.dart';


class ItemModel extends Item {
  ItemModel({
    required super.id,
    required super.itemName,
    required super.description,
    required super.imageUrl,
    required super.baseVariant,
    required super.variants,
    required super.unitDetails,
    required super.visibleOnline,
    required super.categoryIdMapName,
    required super.uploadDetails,
    required super.index,
    required super.deleted,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    dekhao(map.toString());
    Reference? urlRef;
    try {
       urlRef = FirebaseStorage.instance.ref(map['imageUrl'] as String);
    } catch (e) {
      "";
    }
    return ItemModel(
      id: map['id'],
      itemName: map['itemName'],
      description: map['description'],
      imageUrl: urlRef,
      baseVariant: VariantModel.fromMap(map['baseVariant']),
      variants: (map["variants"] as Map<String, dynamic>)
          .map((k,v) => MapEntry(k, VariantModel.fromMap(v))),
      unitDetails: UnitModel.fromMap(map: map['unitDetails']),
      visibleOnline: map['visibleOnline'],
      categoryIdMapName: Map<String, String>.from(map['categoryIdMapName']),
      uploadDetails: UploadMetaModel.fromMap(map['uploadDetails']),
      index: map['index'],
      deleted: map['deleted'],
    );
  }

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      itemName: item.itemName,
      description: item.description,
      imageUrl: item.imageUrl,
      baseVariant: item.baseVariant,
      variants: item.variants,
      unitDetails: item.unitDetails,
      visibleOnline: item.visibleOnline,
      categoryIdMapName: item.categoryIdMapName,
      uploadDetails: item.uploadDetails,
      index: item.index,
      deleted: item.deleted,
    );
  }

  Map<String, dynamic> toRemote() {
    
    return {
      'id': id,
      'itemName': itemName,
      'description': description,
      'imageUrl': imageUrl.fullPath,
      'baseVariant': VariantModel.fromEntity(baseVariant).toRemote(),
      'variants': variants.map((k,v) => MapEntry(k, VariantModel.fromEntity(v).toRemote())),
      'unitDetails': UnitModel.fromEntity(unitDetails).toMap(),
      'visibleOnline': visibleOnline,
      'categoryIdMapName': categoryIdMapName,
      'uploadDetails': UploadMetaModel.fromEntity(uploadDetails).toRemote(),
      'index': index,
      'deleted': deleted,
    };
  }

  Map<String, dynamic> toLocal() {
    return {
      'id': id,
      'itemName': itemName,
      'description': description,
      'imageUrl': imageUrl.fullPath,
      'baseVariant':  VariantModel.fromEntity(baseVariant).toLocal(),
      'variants': variants.map((k,v) => MapEntry(k, VariantModel.fromEntity(v).toLocal())),
      'unitDetails': unitDetails,
      'visibleOnline': visibleOnline,
      'categoryIdMapName': categoryIdMapName,
      'uploadDetails': uploadDetails,
      'index': index,
      'deleted': deleted,
    };
  }
  
}
