
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../domain/entities/user_prv.dart';
import '../../domain/entities/user_pub.dart';
import '../../domain/repositories/user_repo.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../models/user_prv_model.dart';
import '../models/user_pub_model.dart';
import '../models/user_sync_model.dart';

class UserRepoImpl implements UserRepo{

  final UserInfoRemoteDatasource _userRemoteDatasource;
  final UserInfoLocalDatasource _userLocalDatasource;

  UserRepoImpl(this._userRemoteDatasource, this._userLocalDatasource);

  @override
  Future<Either<DataCRUDFailure, Success>> openLocalDb() async{
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _userLocalDatasource.openBox() .then((value) => Success(message: "Store is saved.."));
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, UserPrv?>> fetchCurrentUserInfo({bool? forceFetch}) async{
    return await _remotefetchUserInfo(forceFetch: forceFetch).then((value) async{
      return await value.fold(
        (l) async{
          dekhao('UserRepoImpl/fetchCurrentUserInfo user remote data is null');
          return await _localfetchUserInfo();
        }, (user) async{
          if(user != null) {
            dekhao('UserRepoImpl/fetchCurrentUserInfo user is fetched');
            await _saveUserInfoAtLocal(UserSync(type: DocumentChangeType.added, userPrv: UserPrvModel.fromEntity(user), isSynced: true));
          }
          return Right(user);
        });
    });
  }

  Future<Either<DataCRUDFailure, UserPrv?>> _remotefetchUserInfo({bool? forceFetch}) async{
    return await asyncTryCatch<UserPrv?>(tryFunc: ()async{
      return await _userRemoteDatasource.fetchCurrentUserInfo(forceFetch: forceFetch);
    });
  }

  Future<Either<DataCRUDFailure, UserPrv?>> _localfetchUserInfo() async{
    return await asyncTryCatch<UserPrv?>(tryFunc: ()async{
      return await _userLocalDatasource.fetchCurrentUserInfo().then((value) {
        if(value == null) return null;
        return value.userPrv;
      });
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> saveUserInfo(UserPrv user) async{
    return _saveUserInfoAtRemote(user).then((value) {
      return value.fold(
        (l) async{
          return await _saveUserInfoAtLocal(UserSync(type: DocumentChangeType.added, userPrv: UserPrvModel.fromEntity(user), isSynced: false));
        }, (r)  async{
          return await _saveUserInfoAtLocal(UserSync(type: DocumentChangeType.added, userPrv: UserPrvModel.fromEntity(user), isSynced: true));
        });
    });
  }
  
  Future<Either<DataCRUDFailure, Success>> _saveUserInfoAtLocal(UserSync userSync) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return await _userLocalDatasource.saveUserInfo(userSync).then((value) => Success());
    });
  }

  Future<Either<DataCRUDFailure, Success>> _saveUserInfoAtRemote(UserPrv userPrv) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return await _userRemoteDatasource.saveUserInfo(userPrv:  UserPrvModel.fromEntity(userPrv), userPub: UserPubModel.fromPrivateEntity(userPrv)).then((value) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, UserPub>> fetchUserInfo({required String userId}) async{
    return asyncTryCatch<UserPub>(tryFunc: () async{
      return await _userRemoteDatasource.fetchUserInfo(userId: userId);
    });
  }

}