import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/image_repo.dart';

class SaveImageWithReferencePath implements AsyncEitherUsecase<ImageX, SaveImageWithReferencePathParams>{

  final ImageRepo _imageRepo;

  SaveImageWithReferencePath(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, ImageX>> call(SaveImageWithReferencePathParams params) async{
    return await _imageRepo.saveImageWithReferencePath(imageData: params.imageData, referencePath: params.referencePath);
  }

}

class SaveImageWithReferencePathParams{
  final Reference referencePath;
  final Uint8List imageData;

  SaveImageWithReferencePathParams({required this.referencePath, required this.imageData});
}