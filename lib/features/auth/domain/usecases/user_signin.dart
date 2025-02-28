

import '../entities/credentials.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repo.dart';

class UserSignIn implements AsyncEitherUsecase<Success, InputCredential> {

  final AuthRepo _authRepo;

  UserSignIn( this._authRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(InputCredential params) async{
    return await  _authRepo.signIn(email: params.email.email, password: params.password.password);
  }
}

