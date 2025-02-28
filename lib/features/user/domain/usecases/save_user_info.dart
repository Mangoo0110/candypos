import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/user_prv.dart';
import '../repositories/user_repo.dart';

class SaveUserInfo implements AsyncEitherUsecase<Success, UserPrv>{

  final UserRepo _userRepo;

  SaveUserInfo(this._userRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(UserPrv params) async{
    return await _userRepo.saveUserInfo(params);
  }

}