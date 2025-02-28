import 'dart:typed_data';

import 'package:candypos/core/utils/constants/data_field_key_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../../core/utils/func/dekhao.dart';
import '../../../../../store/data/datasources/hive/hive_store_datasource.dart';
import '../../models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class ItemRemoteDatasource {

  Future<void> createItem({required ItemModel item, required Uint8List? image});

  Future<void> updateItem({required ItemModel? item, required Uint8List? image, required Reference reference});

  Stream<List<ItemModel>> fetchItems();

  Future<void> deleteItem({required String itemId});

}



class ItemRemoteDatasourceImpl implements ItemRemoteDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  static ItemRemoteDatasourceImpl? _instance;

  ItemRemoteDatasourceImpl._internal();

  static ItemRemoteDatasourceImpl get instance {
    _instance ??= ItemRemoteDatasourceImpl._internal(); 
    return _instance!;
  }

  CollectionReference<Map<String, dynamic>>  _itemCollection(){

    final currentUser = FirebaseAuth.instance.currentUser;
    final currentStore = StoreHiveImpl.instance.currentStore;

    if(currentUser == null){
      throw FirebaseAuthException(code: "404", message: "User is not logged in!");
    }

    if(currentStore == null){
      throw Exception("No logged in store is found!");
    }

    dekhao("creating _itemCollection... ${currentUser.uid} > ${currentStore.id}");
    
    return FirebaseFirestore.instance
        .collection(FirestoreUserPub.kCollection).doc(currentUser.uid)
        .collection("stores").doc(currentStore.id)
        .collection("items"); 
  }

  @override
  Future<void> createItem({required ItemModel item, required Uint8List? image, }) async {
    await _itemCollection().doc(item.id).set(item.toRemote());
    if(image != null) await item.imageUrl.putData(image);
  }


  @override
  Future<void> updateItem({required ItemModel? item, required Uint8List? image, required Reference reference}) async {
    if(item != null) await _itemCollection().doc(item.id).update(item.toRemote());
    if(image != null) await reference.putData(image);
  }


  int _itemListenCount = 0;

  @override
  Stream<List<ItemModel>> fetchItems() {

    return _itemCollection().snapshots().map((snapshot) {
      
      dekhao("snapshot fetched${"\n\n\n"}${_itemListenCount++} times.");
      List<ItemModel> newItems = [];
      for(final docChange in snapshot.docChanges) {
        if(docChange.doc.exists && docChange.doc.data() != null) {
          try {
            final item = ItemModel.fromMap(docChange.doc.data()!);
            newItems.add(item);
          } catch (e) {
            dekhao(e);
          }
        }
      }
      return newItems;
    });
  }

  @override
  Future<void> deleteItem({required String itemId}) async {
    await _itemCollection().doc(itemId).delete();
  }
}