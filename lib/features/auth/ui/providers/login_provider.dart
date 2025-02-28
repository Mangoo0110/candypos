
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../../../../core/common/enums/common_enums.dart';

// import '../../../../init_dependency.dart';
// import '../../../../save_status_provider.dart';
// import '../../domain/usecases/user_signin.dart';

// class LoginProvider extends ChangeNotifier{
//   String _email = '';
//   String _password = '';

//   final Key _key = GlobalKey(debugLabel: "LoginProvider");

//   final RegExp emailRegExp = RegExp(
//     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//   );

//   final RegExp passwordRegExp = RegExp(
//     r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
//   );

//   late SaveStatusNotifier _loginNotifier;

//   SaveStatusNotifier get loginNotifier => _loginNotifier;

//   String get email => _email;

//   String get password => _password;



//   void checkCanRegister(){
//     if(!emailRegExp.hasMatch(_email) || _password.isEmpty){
//       _loginNotifier.setSaveStatus(_key,  SaveStatus.canNotSave);
      
//     } else {
//       _loginNotifier.setSaveStatus(_key,  SaveStatus.canSave);
      
//     }
//   }

//   void setEmail(String email){
//     _email = email;
//     checkCanRegister();
//   }

//   void setPassword(String password){
//     _password = password;
//     checkCanRegister();
//   }

//   Future<void> loginBang({
//     required VoidCallback onDone
//   }) async{
//     _loginNotifier.setSaveStatus(_key,  SaveStatus.saving); 
//     await serviceLocator<UserSignIn>().call(UserSignInParams(email: email, password: password)).then((value) {
      
//       value.fold((l) {
//         _loginNotifier.setSaveStatus(_key,  SaveStatus.failed); 

//         Fluttertoast.showToast(msg: "Login failed!. ${l.message}");
//       }, (r) async{
//         Fluttertoast.showToast(msg: "Login successful.");

//         _loginNotifier.setSaveStatus(_key,  SaveStatus.success); 
//         onDone();
//         // await serviceLocator<>().call(NoParams()).then((value) {
//         //   value.fold((l) => null, (r) => onDone());
//         // });
//       });
      
//     });
//   }

// }