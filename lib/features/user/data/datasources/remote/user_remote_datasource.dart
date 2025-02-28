import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/constants/data_field_key_names.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../models/user_prv_model.dart';
import '../../models/user_pub_model.dart';

abstract interface class UserInfoRemoteDatasource{

  Future<UserPrvModel> fetchCurrentUserInfo({bool? forceFetch});

  Future<UserPubModel> fetchUserInfo({required String userId});

  Future<void> saveUserInfo({required UserPrvModel userPrv, required UserPubModel userPub});
}

class UserFirestoreImpl implements UserInfoRemoteDatasource{

  DateTime _currentUserLastFetchedAt = DateTime.now().subtract(const Duration(hours: 1));

  UserPrvModel? _currentUser ;

  static UserFirestoreImpl? _instance;

  UserFirestoreImpl._();

  static UserFirestoreImpl get instance {
    _instance ??= UserFirestoreImpl._();
    return _instance!;
  }

  CollectionReference<Map<String, dynamic>> _prvCollectionRef(){ 
    return FirebaseFirestore.instance.collection(FirestoreUserPrv.kCollection);
  }


  CollectionReference<Map<String, dynamic>> _pubCollectionRef(){ 
    return FirebaseFirestore.instance.collection(FirestoreUserPub.kCollection);
  }

  @override
  Future<UserPrvModel> fetchCurrentUserInfo({bool? forceFetch}) async{
    if(forceFetch != null && !forceFetch && DateTime.now().difference(_currentUserLastFetchedAt).inMinutes < 10 && _currentUser != null) {
      dekhao("User data already exists!");
      return _currentUser!;
    }
    return await _prvCollectionRef()
      .doc(AuthFirebaseImpl.instance.currentUserAuth!.id).get()
      .then((value) {

        dekhao(value.data().toString());
        try {

          if(value.data() == null){
            throw Exception('Fatal!! Data not found!');
          }
          final userPrv = UserPrvModel.fromMap(value.data()!);
          _currentUser = userPrv;
          _currentUserLastFetchedAt = DateTime.now();
          return userPrv;
        } catch (e) {
          dekhao('fetchCurrentUserInfo UserPrvModel failed!. error ${e.toString()}');
          throw FormatException("Firestore user data formating to UserPrvModel failed!", value.data()!.toString());
        }
      });
    
  }


  @override
  Future<void> saveUserInfo({required UserPrvModel userPrv, required UserPubModel userPub}) async{
    if(AuthFirebaseImpl.instance.currentUserAuth == null) return;

    WriteBatch batch = FirebaseFirestore.instance.batch();
    batch.set(_prvCollectionRef().doc(userPrv.id), userPrv.toMap());
    batch.set(_pubCollectionRef().doc(userPrv.id), userPub.toMap());
    await batch.commit();
  }
  
  @override
  Future<UserPubModel> fetchUserInfo({required String userId}) async{
    return await _pubCollectionRef()
    .doc(AuthFirebaseImpl.instance.currentUserAuth!.id).get()
    .then((value) {
      
      try {

        if(value.data() == null){
          throw Exception('Fatal!! Data not found!');
        }
        final userPub = UserPubModel.fromMap(value.data()!);
        return userPub;
      } catch (e) {
        throw FormatException("Firestore user data formating failed!", value.data()!.toString());
      }
    });
  }

}