import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repo.dart';

class UserSignOut implements AsyncEitherUsecase<Success, NoParams> {
  final AuthRepo _authRepo;

  UserSignOut( this._authRepo);
  
  @override
  Future<Either<DataCRUDFailure, Success>> call(NoParams params) async{
    return await  _authRepo.signOut();
  }
}