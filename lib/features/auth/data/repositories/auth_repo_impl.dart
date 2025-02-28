


import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../domain/entities/user_auth.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepoImpl implements AuthRepo{

  final RemoteAuthDataSource _firebaseAuthDataSource;

  AuthRepoImpl(this._firebaseAuthDataSource);

  

  @override
  bool isUserSignedIn() {
    return _firebaseAuthDataSource.isSignedIn();
  }

  @override
  Stream<UserAuth?> get currentUserAuth => _firebaseAuthDataSource.currentUserAuthStream;
  
  @override
  Future<Either<DataCRUDFailure, Success>> signIn({required String email, required String password}) async{
    return await asyncTryCatch<Success>(
      tryFunc:() async{
        return await _firebaseAuthDataSource.signIn(email: email, password: password).then((value) => Success(message: "Signed in successfully."));
      }
    );
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> signOut() async{
    return await asyncTryCatch<Success>(
      tryFunc:() async{
        return await _firebaseAuthDataSource.signOut().then((value) => Success(message: "Signed out successfully."));
      }
    );
  }
  
  @override
  Future<Either<DataCRUDFailure, UserAuth>> signUp({required String email, required String password}) async{

    return await asyncTryCatch<UserAuth>(
      tryFunc:() async{
        return await _firebaseAuthDataSource.signUp(email: email, password: password);
      }
    );
    
  }
  
}