import 'package:candypos/core/api_handler/success.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/store_model.dart';
import '../repositories/store_repo.dart';


class UpdateStoreInfo implements AsyncEitherUsecase<Success, UpdateStoreInfoParams>{
  final StoreRepo _repo;

  UpdateStoreInfo(this._repo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(UpdateStoreInfoParams params) async{
    return await _repo.updateStoreInfo(updateStoreInfoParams: params);
  }


}


class UpdateStoreInfoParams {
  final String storeId;
  final String? storeName;
  final String? imageUrl;
  final String? address;
  final String? contactNo;

  UpdateStoreInfoParams({
    required this.storeId,
    required this.storeName,
    required this.imageUrl,
    required this.address,
    required this.contactNo,
  });

  Map<String, dynamic> toMap() {
    return {
      if(storeName != null) StoreRemoteDataFields.storeName : storeName,
      if(imageUrl != null) StoreRemoteDataFields.imageUrl : imageUrl,
      if(address != null) StoreRemoteDataFields.address : address,
      if(contactNo != null) StoreRemoteDataFields.contactNo : contactNo,
    };
  }
}