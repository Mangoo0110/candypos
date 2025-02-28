import 'package:dartz/dartz.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../entities/user_prv.dart';
import '../entities/user_pub.dart';

abstract interface class UserRepo{

  Future<Either<DataCRUDFailure, Success>> openLocalDb();

  Future<Either<DataCRUDFailure, UserPrv?>> fetchCurrentUserInfo({bool? forceFetch});

  Future<Either<DataCRUDFailure, UserPub>> fetchUserInfo({required String userId});

  Future<Either<DataCRUDFailure, Success>> saveUserInfo(UserPrv user);
}