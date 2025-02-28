import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/store.dart';
import '../repositories/store_repo.dart';

import '../../../../core/api_handler/failure.dart';

class SaveAsCurrentStore implements AsyncEitherUsecase<Success, Store>{
  final StoreRepo _storeRepo;

  SaveAsCurrentStore(this._storeRepo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(Store store) async{
    return await _storeRepo.saveAsCurrentStore(store: store);
  }


}