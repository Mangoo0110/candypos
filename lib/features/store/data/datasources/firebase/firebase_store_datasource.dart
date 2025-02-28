
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/utils/constants/data_field_key_names.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../../domain/usecases/update_store_info.dart';
import '../../models/store_model.dart';
import '../hive/hive_store_datasource.dart';


abstract interface class RemoteStoreDatasource{

  Future<void> createStore({required StoreModel storeModel});
  
  Future<void> updateStoreInfo({
    required UpdateStoreInfoParams updateStoreInfoParams
  });

  /// Careful!!
  /// 
  /// If Store is deleted,  then all of its subcollections and their data will also be deleted automatically.
  Future<void> deleteStore({required String storeId});

  Future<StoreModel?> getStore({required String storeId});

  /// Returns [List<StoreModel>].
  Future<List<StoreModel>> fetchAllStoresOfUser(); 
  
}

class StoreFirebaseImpl implements RemoteStoreDatasource {

  AuthFirebaseImpl? _firebaseAuthDataSourceImpl;

  static StoreFirebaseImpl? _instance;

  late Stream<User?> firebaseUserAuthStream;


  StoreFirebaseImpl._internal();

  static StoreFirebaseImpl get instance {
    _instance ??= StoreFirebaseImpl._internal(); 
    return _instance!;
  }



  CollectionReference<Map<String, dynamic>>  _storeCollection(){
    _firebaseAuthDataSourceImpl ??= AuthFirebaseImpl.instance;
    final currentUser = FirebaseAuth.instance.currentUser;
    //final currentStore = StoreHiveImpl.instance.currentStore;

    if(currentUser == null){
      throw FirebaseAuthException(code: "404", message: "User is not logged in!");
    }

    // if(currentStore == null){
    //   throw Exception("No logged in store is found!");
    // }

    dekhao("creating _itemCollection...");

    return FirebaseFirestore.instance
        .collection(FirestoreUserPub.kCollection).doc(currentUser.uid)
        .collection("stores");
  }

  // void getCurrentFirebaseUser(){
  //   firebaseUserAuthStream = _firebaseAuthDataSourceImpl!.currentFirebaseUserAuthStream;
  //   firebaseUserAuthStream.listen((event) {
  //     if(event != null) {

  //     }
  //   },);
  // }


  @override
  Future<void> createStore({required StoreModel storeModel}) async{
    if(storeModel.toMap().isEmpty) return;
    try {
       await _storeCollection().doc(storeModel.id).set(storeModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> deleteStore({required String storeId}) async{
    try {
      await _storeCollection().doc(storeId).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StoreModel?> getStore({required String storeId}) async{
    
    try {
     return await _storeCollection().doc(storeId).get().then((value) async{
      if(value.data() == null) {
        return null;
      } else{
        return StoreModel.fromMap(value.data()!);
      }
     });
    } catch (e){
      rethrow;
    }

  }
  
  @override
  Future<List<StoreModel>> fetchAllStoresOfUser() async{
    

    return await _storeCollection()
    .where(StoreRemoteDataFields.createdBy, isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .get().then((qSnap) {
      return qSnap.docs.map((docSnap) {
        dekhao(docSnap.data().toString());
        return StoreModel.fromMap(docSnap.data());
      }).toList();
    });

  }
  
  @override
  Future<void> updateStoreInfo({required UpdateStoreInfoParams updateStoreInfoParams}) async{
    return await _storeCollection().doc(updateStoreInfoParams.storeId).update(updateStoreInfoParams.toMap());
  }

}
