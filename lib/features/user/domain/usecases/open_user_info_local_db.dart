import '../../../../core/api_handler/success.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/user_repo.dart';


class OpenUserInfoLocalDb implements AsyncEitherUsecase<Success, NoParams>{
  final UserRepo _repo;

  OpenUserInfoLocalDb(this._repo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(NoParams params) async{
    return await _repo.openLocalDb();
  }


}