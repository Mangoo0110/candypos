

import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/store.dart';
import '../repositories/store_repo.dart';

class FetchAllStoresOfUser implements AsyncEitherUsecase<List<Store>, NoParams> {

  final StoreRepo _storeRepo;

  FetchAllStoresOfUser(this._storeRepo);
  
  @override
  Future<Either<DataCRUDFailure, List<Store>>> call(NoParams params) async{
    return await _storeRepo.fetchAllStoreOfUser();
  }
  

}