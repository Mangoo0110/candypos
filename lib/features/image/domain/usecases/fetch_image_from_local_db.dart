import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/image_repo.dart';

class FetchImageFromLocalDb implements AsyncEitherUsecase<ImageX?, FetchImageFromLocalDbParams>{

  final ImageRepo _imageRepo;

  FetchImageFromLocalDb(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, ImageX>> call(FetchImageFromLocalDbParams params) async{
    return await _imageRepo.fetchImageFromLocalDb(url: params.url);
  }

}


class FetchImageFromLocalDbParams {
  final String url;

  FetchImageFromLocalDbParams({required this.url});
}