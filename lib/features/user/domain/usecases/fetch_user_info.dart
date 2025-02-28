import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/user_pub.dart';
import '../repositories/user_repo.dart';

class FetchUserInfo implements AsyncEitherUsecase<UserPub, String>{

  final UserRepo _userRepo;

  FetchUserInfo(this._userRepo);

  @override
  Future<Either<DataCRUDFailure, UserPub>> call(String params) async{
    return await _userRepo.fetchUserInfo(userId: params);
  }

}