import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/api_handler/trycatch.dart';
import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/api_handler/success.dart';
import '../../domain/entities/item.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/item_repo.dart';
import '../datasources/remote/item_remote_datasource.dart';
import '../models/item_model.dart';


class ItemRepoImpl implements ItemRepo{

  final ItemRemoteDatasource _remoteDatasource;

  ItemRepoImpl(this._remoteDatasource);
  
  @override
  Future<Either<DataCRUDFailure, Success>> createItem({required Item item, required Uint8List? image}) async{
      return await asyncTryCatch<Success>(tryFunc:() async{
        return await _remoteDatasource.createItem(
          item: ItemModel.fromEntity(item),
          image: image
        ).then((_) => Success(message: "Item is saved."));
      });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> updateItem({required Item? item, required Uint8List? image, required Reference reference}) async{
      return await asyncTryCatch<Success>(tryFunc:() async{
        return await _remoteDatasource.updateItem(
          item: item == null ? null : ItemModel.fromEntity(item),
          image: image,
          reference: reference
        ).then((_) => Success(message: "Item is saved."));
      });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> deleteItem({required String itemId}) async{
      return await asyncTryCatch<Success>(tryFunc:() async{
        return await _remoteDatasource.deleteItem(itemId: itemId).then((_) => Success(message: "Item is deleted."));
      });
  }

  @override
  Either<DataCRUDFailure, Stream<List<Item>>> fetchItems() {
      return  tryCatch<Stream<List<Item>>>(tryFunc:() {
        return _remoteDatasource.fetchItems();
      });
  }

}