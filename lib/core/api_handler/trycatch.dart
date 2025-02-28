import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/func/dekhao.dart';
import 'exceptions.dart';
import 'failure.dart';



Future<Either<DataCRUDFailure, T>> asyncTryCatch<T>({required Future<T> Function() tryFunc, }) async{
    try {
      return await tryFunc().then((value) => Right(value));
      
    } on ServerException catch(e){
      dekhao(e);
      return Left(DataCRUDFailure(failure: Failure.severFailure, message: 'Server failed!'));
    } on NoDataException catch(e){
      dekhao(e);
      return Left(DataCRUDFailure(failure: Failure.noData, message: "Doesn't exist!"));
    } on SocketException {
      return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
    } on FirebaseAuthException catch(e){
      dekhao(e);
      return Left(DataCRUDFailure(failure: Failure.authFailure, message: e.message ?? ''));
    }on FirebaseException catch(e){
      dekhao(e);
      return Left(DataCRUDFailure(failure: Failure.firebaseFailure, message: 'Firebase failure! ${'\n'} Error: ${e.toString()}'));
    } catch (e) {
      dekhao(e);
      return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: 'Some error occured. ${'\n'} Error: ${e.toString()}'));
    }
}

Either<DataCRUDFailure, T> tryCatch<T>({required T Function() tryFunc, }) {
    try {
      return Right(tryFunc());
      
    } on ServerException {
      return Left(DataCRUDFailure(failure: Failure.severFailure, message: ''));
    } on SocketException {
      return Left(DataCRUDFailure(failure: Failure.socketFailure, message: 'Internet connection failed!'));
    } on FirebaseAuthException catch(e){
      return Left(DataCRUDFailure(failure: Failure.authFailure, message: e.message ?? ''));
    }on FirebaseException catch(e){
      return Left(DataCRUDFailure(failure: Failure.firebaseFailure, message: 'Firebase failure! ${'\n'} Error: ${e.toString()}'));
    } catch (e) {
      return Left(DataCRUDFailure(failure: Failure.unknownFailure, message: 'Some error occured. Error: ${e.toString()}'));
    }
}