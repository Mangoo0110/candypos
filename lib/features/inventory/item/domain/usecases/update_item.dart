import 'dart:typed_data';

import 'package:candypos/core/api_handler/success.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/api_handler/failure.dart';
import '../entities/item.dart';
import '../repositories/item_repo.dart';

import 'package:dartz/dartz.dart';

import '../../../../../core/usecases/usecases.dart';

class UpdateItem implements AsyncEitherUsecase<Success, UpdateItemParams>{

  final ItemRepo _repo;

  UpdateItem(this._repo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(UpdateItemParams params) async{
    return await _repo.updateItem(item: params.item, image: params.image, reference: params.reference);
  }
  
}

class UpdateItemParams{
  final Item? item;
  final Uint8List? image;
  final Reference reference;
  UpdateItemParams({required this.item, required this.image, required this.reference});
}