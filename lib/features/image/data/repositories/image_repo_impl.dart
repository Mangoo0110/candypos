

import 'dart:collection';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../datasources/hive/image_local_datasource.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../domain/repositories/image_repo.dart';
import '../datasources/firebase/image_firebase_datasource.dart';

class ImageRepoImpl implements ImageRepo{

  final SplayTreeMap<String, ImageX> _images = SplayTreeMap<String, ImageX>();

  final ImageRemoteDatasource _imageRemoteDatasource;
  final ImageLocalDatasource _imageLocalDatasource;

  ImageRepoImpl(this._imageRemoteDatasource, this._imageLocalDatasource);

  @override
  Future<Either<DataCRUDFailure, ImageX>> fetchImage({required Reference url, bool? forceFetch}) async{
    return asyncTryCatch<ImageX>(tryFunc: ()async{
      return await _imageRemoteDatasource.fetchImage(storageRef: url);
    });
  }

  @override
  Future<Either<DataCRUDFailure, ImageX>> saveImageWithUrl({required Uint8List imageData, required String existingImageUrl}) async{
    return asyncTryCatch<ImageX>(tryFunc: ()async{
      return await _imageRemoteDatasource.saveImageWithUrl(existingImageUrl: existingImageUrl, image: imageData).then((imageRemote) {
        _images[existingImageUrl] = imageRemote; 
        return imageRemote;
      });
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> deleteImage({required String imageUrl}) async{
    return asyncTryCatch<Success>(tryFunc: ()async{
      return await _imageRemoteDatasource.deleteImage(imageUrl: imageUrl).then((value) => Success());
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, ImageX>> saveImageWithReferencePath({required Reference referencePath, required Uint8List imageData}) async{
    return  asyncTryCatch<ImageX>(tryFunc: () async{
      return await _imageRemoteDatasource.saveImageWithReferencePath(referencePath: referencePath, image: imageData);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, ImageX>> saveImageLocally({required Uint8List imageData, required String imageUrl}) async{
    return  asyncTryCatch<ImageX>(tryFunc: () async{
      return await _imageLocalDatasource.saveImage(referencePath: imageUrl, image: imageData);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, ImageX>> fetchImageFromLocalDb({required String url}) async{
    return await asyncTryCatch<ImageX>(tryFunc: () async{
      return await _imageLocalDatasource.fetchImage(imageUrl: url);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> deleteImageFromLocalDb({required String imageUrlKey}) async{
    return asyncTryCatch<Success>(tryFunc: ()async{
      return await _imageLocalDatasource.deleteImage(imageUrl: imageUrlKey).then((value) => Success());
    });
  }

}




