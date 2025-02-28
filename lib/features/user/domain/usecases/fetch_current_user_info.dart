import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/user_prv.dart';
import '../repositories/user_repo.dart';

class FetchCurrentUserInfo implements AsyncEitherUsecase<UserPrv?, bool?>{

  final UserRepo _userRepo;

  FetchCurrentUserInfo(this._userRepo);

  @override
  Future<Either<DataCRUDFailure, UserPrv?>> call(bool? forceFetch) async{
    return await _userRepo.fetchCurrentUserInfo(forceFetch: forceFetch);
  }

}