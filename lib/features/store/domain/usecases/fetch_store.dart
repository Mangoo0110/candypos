import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/store.dart';
import '../repositories/store_repo.dart';

import '../../../../core/api_handler/failure.dart';


class FetchCurrentStore implements AsyncEitherUsecase<Store?, NoParams>{

  final StoreRepo _storeRepo;

  FetchCurrentStore(this._storeRepo);

  @override
  Future<Either<DataCRUDFailure, Store?>> call(NoParams params) async{
    return await _storeRepo.fetchCurrentStore();
  }

}