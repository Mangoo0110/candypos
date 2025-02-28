import '../../../../core/api_handler/success.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/store_repo.dart';


class OpenStoreLocalDb implements AsyncEitherUsecase<Success, NoParams>{
  final StoreRepo _repo;

  OpenStoreLocalDb(this._repo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(NoParams params) async{
    return await _repo.openLocalDb();
  }


}