import '../../../../../core/api_handler/failure.dart';
import '../entities/item.dart';
import '../repositories/item_repo.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';

class FetchItems implements EitherUsecase<Stream<List<Item>>, NoParams>{

  final ItemRepo _repo;

  FetchItems(this._repo);
  
  @override
  Either<DataCRUDFailure, Stream<List<Item>>> call(NoParams params) {
    return _repo.fetchItems();
  }
  
}