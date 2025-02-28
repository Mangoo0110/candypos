// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/user_auth.dart';

abstract interface class RemoteAuthDataSource {

  bool isSignedIn();

  Stream<UserAuth?> get currentUserAuthStream;



  Future<UserAuth> signUp({
    required String email,
    required String password,
  });

  Future<void> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  /// Deletes and signs out the user.
  ///
  /// **Important**: this is a security-sensitive operation that requires the
  /// user to have recently signed in. If this requirement isn't met, ask the
  /// user to authenticate again and then call [User.reauthenticateWithCredential].
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **requires-recent-login**:
  ///  - Thrown if the user's last sign-in time does not meet the security
  ///    threshold. Use [User.reauthenticateWithCredential] to resolve. This
  ///    does not apply if the user is anonymous.
  /// 
  //Future<void> deleteAccount();
}

class AuthFirebaseImpl implements RemoteAuthDataSource {

  static AuthFirebaseImpl? _instance; 
  late FirebaseAuth _authInstance;

  UserAuth? _currentUserAuth;

  AuthFirebaseImpl._(){
    _authInstance = FirebaseAuth.instance;
  }

  static AuthFirebaseImpl get instance {
    _instance ??= AuthFirebaseImpl._();
    return _instance!;
  }

  UserAuth? get currentUserAuth {

    if(_currentUserAuth != null) return _currentUserAuth;
    if(_authInstance.currentUser == null) return null;

    return UserAuth.fromFirebaseAuthUser(
      currentUser: _authInstance.currentUser!
    );

  }

  @override
  Stream<UserAuth?> get currentUserAuthStream {
    return _authInstance.authStateChanges().map((firebaseUser) {
      if(firebaseUser == null) return null;
      _currentUserAuth = UserAuth.fromFirebaseAuthUser(
        currentUser: _authInstance.currentUser!
      );

      return _currentUserAuth;
    });
  }

  Stream<User?> get currentFirebaseUserAuthStream {
    return _authInstance.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  bool isSignedIn() {
    if (_authInstance.currentUser == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> signOut() async {
    try {
      await _authInstance.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserAuth> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _authInstance
        .createUserWithEmailAndPassword(email: email, password: password).then((userCredential){
          _currentUserAuth = UserAuth.fromFirebaseAuthUser(
            currentUser: _authInstance.currentUser!
          );
          //saveUserInfo(userAuth: _currentUserAuth!);
        });
      
      return _currentUserAuth!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
        email: email, password: password).then((userCredential){
          _currentUserAuth = UserAuth.fromFirebaseAuthUser(
            currentUser: _authInstance.currentUser!
          );
          //saveUserInfo(userAuth: _currentUserAuth!);
        });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount() async{
    if(_authInstance.currentUser != null){
      try {
        return await _authInstance.currentUser!.delete();
      } catch (e) {
        rethrow;
      }
    }
  }


//   Future<void> saveUserInfo({required UserAuth userAuth}) async{
//     if(AuthFirebaseImpl.instance.currentUserAuth == null) return;

//     final userPrivateData = {
//       FirestoreUserPrv.kdocId: userAuth.id,
//       FirestoreUserPrv.kemail: userAuth.email,
//     };



//     WriteBatch batch = FirebaseFirestore.instance.batch();
//     batch.set(_prvCollectionRef().doc(userAuth.id), userPrivateData);
//     //batch.set(_pubCollectionRef().doc(userAuth.id), userPrivateData);
//     await batch.commit();
//   }

}

