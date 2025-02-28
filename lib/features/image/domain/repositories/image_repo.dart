
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';


class ImageX {
  final String url;
  late DateTime _fetchedAt;
  final Uint8List image;
  final bool? fromLocalDb;

  ImageX({required this.url, required this.image, this.fromLocalDb}){
    _fetchedAt = DateTime.now();
  }

  //getters
  DateTime get fetchedAt => _fetchedAt;


}

abstract interface class ImageRepo{
  Future<Either<DataCRUDFailure, ImageX>> fetchImage({required Reference url, bool? forceFetch});
  
  Future<Either<DataCRUDFailure, ImageX>> fetchImageFromLocalDb({required String url,});

  Future<Either<DataCRUDFailure, ImageX>> saveImageWithUrl({required Uint8List imageData, required String existingImageUrl});

  Future<Either<DataCRUDFailure, ImageX>> saveImageLocally({required Uint8List imageData, required String imageUrl});

  Future<Either<DataCRUDFailure, ImageX>> saveImageWithReferencePath({required Reference referencePath, required Uint8List imageData});

  Future<Either<DataCRUDFailure, Success>> deleteImage({required String imageUrl});

  Future<Either<DataCRUDFailure, Success>> deleteImageFromLocalDb({required String imageUrlKey});
}

