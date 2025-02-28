import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/credentials.dart';
import '../entities/user_auth.dart';
import '../repositories/auth_repo.dart';

class UserSignUp implements AsyncEitherUsecase<UserAuth, InputCredential> {
  final AuthRepo _authRepo;

  UserSignUp( this._authRepo);

  @override
  Future<Either<DataCRUDFailure, UserAuth>> call(InputCredential params) async{
    return await  _authRepo.signUp(email: params.email.email, password: params.password.password);
  }
}
