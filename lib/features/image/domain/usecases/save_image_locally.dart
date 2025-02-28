import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/image_repo.dart';

class SaveImageLocally implements AsyncEitherUsecase<ImageX, SaveImageLocallyParams>{

  final ImageRepo _imageRepo;

  SaveImageLocally(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, ImageX>> call(SaveImageLocallyParams params) async{
    return await _imageRepo.saveImageLocally(imageData: params.imageData, imageUrl: params.url);
  }

}

class SaveImageLocallyParams{
  /// Url of the image
  final String url;
  final Uint8List imageData;

  SaveImageLocallyParams({required this.url, required this.imageData});
}