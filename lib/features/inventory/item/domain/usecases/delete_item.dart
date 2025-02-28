import 'package:candypos/core/api_handler/success.dart';

import '../../../../../core/api_handler/failure.dart';
import '../repositories/item_repo.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';

class DeleteItem implements AsyncEitherUsecase<Success, String>{

  final ItemRepo _repo;

  DeleteItem(this._repo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(String params) async{
    return await _repo.deleteItem(itemId: params);
  }
  
}