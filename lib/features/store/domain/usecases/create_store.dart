import 'package:candypos/core/api_handler/success.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/store.dart';
import '../repositories/store_repo.dart';


class CreateStore implements AsyncEitherUsecase<Success, Store>{
  final StoreRepo _repo;

  CreateStore(this._repo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(Store params) async{
    return await _repo.createNewStore(store: params);
  }


}