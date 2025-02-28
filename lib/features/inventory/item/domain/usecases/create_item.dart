import 'dart:typed_data';

import 'package:candypos/core/api_handler/success.dart';

import '../../../../../core/api_handler/failure.dart';
import '../entities/item.dart';
import '../repositories/item_repo.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';

class CreateItem implements AsyncEitherUsecase<Success, CreateItemParams>{

  final ItemRepo _repo;

  CreateItem(this._repo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(CreateItemParams params) async{
    return await _repo.createItem(item: params.item, image: params.image);
  }
  
}

class CreateItemParams{
  final Item item;
  final Uint8List? image;

  CreateItemParams({required this.item, required this.image});
}