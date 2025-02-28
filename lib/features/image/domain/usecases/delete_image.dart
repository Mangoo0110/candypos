
import 'package:dartz/dartz.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/image_repo.dart';

class DeleteImage implements AsyncEitherUsecase<Success, String>{

  final ImageRepo _imageRepo;

  DeleteImage(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, Success>> call(String params) async{
    return await _imageRepo.deleteImage(imageUrl: params);
  }

}