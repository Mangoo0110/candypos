
import 'package:flutter/material.dart';


import '../../../../core/usecases/usecases.dart';
import '../../../../init_dependency.dart';
import '../../domain/entities/user_auth.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/user_is_logged_in.dart';






class UserAuthProvider extends ChangeNotifier {

  bool _isLoggedIn = false;

  String _userId = '';

  UserAuth? _userAuth;

  UserAuthProvider(){
  }


  
  String get userId => _userId;

  UserAuth? get userAuth => _userAuth;

  bool isUserSignedIn(){
    return serviceLocator<IsUserSignedIn>().call(NoParams());
  }

  Stream<UserAuth?> getCurrentUserAuth(){

    final res = serviceLocator<GetCurrentUserAuth>().call(NoParams());

    res.listen((event) {
      if(event != null) {
        if(_userAuth != event){
          _userAuth = event;
          _userId = event.id;
          notifyListeners();
        }
      }
    });

    return res;
  }




  // Future<void> register({required String email, required String password}) async{
  //   final result = await serviceLocator<UserSignUp>().call(UserSignUpParams(email: email, password: password));
  //   result.fold(
  //     (dataFailure) {
  //       failureToast(dataFailure);
  //     } ,
  //     (success) {
  //       Fluttertoast.showToast(msg: "Great! You are successfully regesterd.");
  //     }
  //   );
  // }

  // Future<void> login({required String email, required String password}) async{
  //   _
  //   final result = await serviceLocator<UserSignIn>().call(UserSignInParams(email: email, password: password));
  //   result.fold(
  //     (dataFailure) {
  //       failureToast(dataFailure);
  //     } ,
  //     (success) {
  //     }
  //   );
  //}
}