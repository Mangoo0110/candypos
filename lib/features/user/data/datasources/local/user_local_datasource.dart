
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/func/dekhao.dart';

import '../../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../models/user_sync_model.dart';

abstract interface class UserInfoLocalDatasource{
  Future<void> openBox();

  Future<UserSync?> fetchCurrentUserInfo();

  Future<void> saveUserInfo(UserSync adminSync);
}

class UserHiveImpl implements UserInfoLocalDatasource{

  static UserHiveImpl? _instance;

  UserHiveImpl._(){
    if(_box == null){
      openBox();
    }
  }

  static UserHiveImpl get instance {
    _instance ??= UserHiveImpl._();
    return _instance!;
  }

  Box<dynamic>? _box;

  final _boxName = 'UserHive';

  @override
  Future<void> openBox() async {
    final currentAuth = FirebaseAuth.instance.currentUser;

    if(currentAuth == null) {
      throw Exception("User auth is not found!");
    }
    String boxName = '${currentAuth.uid}|UserPrv';
    //_onlyDataKey = '${currentAuth.uid}|UserPrv';
    _box ??= await Hive.openBox(boxName);
  }


  void _isBoxNull() {
    if (_box == null) {
      throw Exception(
          "Local db is not open!!! First you need to open the db before accessing any db service.");
    }
  }

  // Future<void> _openBox() async{
  //   _box ??= await Hive.openBox(_boxName);
  //   return;
  // }

  @override
  Future<UserSync?> fetchCurrentUserInfo() async{

    _isBoxNull();

    try {
      if(_box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id).toString() == "null"){
        throw Exception('Fatal!! Data not found!');
      }
      return UserSync.fromMap(_box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id));
    } catch (e) {
      dekhao("Failed! ${'\n\n'} ${_box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id).toString()} failed. ${'\n\n'} Failed.");
      throw FormatException("Hive admin data formatting failed!", _box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id).toString());
    }
  }

  @override
  Future<void> saveUserInfo(UserSync adminSync) async{
    
    _isBoxNull();

    return await _box!.put(adminSync.userPrv.id, adminSync.toMap());
  }

}