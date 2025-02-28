

// import '../../../../save_status_provider.dart';
// import '../../../user/domain/entities/user_prv.dart';
// import '../../../user/domain/usecases/save_user_info.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../../core/common/enums/common_enums.dart';
// import '../../../../core/utils/func/dekhao.dart';
// import '../../../../init_dependency.dart';

// import '../../domain/entities/user_auth.dart';
// import '../../domain/usecases/user_signup.dart';

// class RegisterProvider extends ChangeNotifier {
//   String _email = '';
//   String _password = '';
//   String _confirmPassword = '';

//   final Key _key = GlobalKey(debugLabel: "RegisterProvider");

//   final RegExp emailRegExp = RegExp(
//     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//   );

//   final RegExp passwordRegExp = RegExp(
//     r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
//   );

//   late SaveStatusNotifier _registerNotifier;

//   SaveStatusNotifier get registerNotifier => _registerNotifier;

//   String get email => _email;

//   String get password => _password;

//   String get confirmPassword => _confirmPassword;

//   RegisterProvider(){
//     _registerNotifier = SaveStatusNotifier(_key);
//   }

//   void checkCanRegister() {
//     // If doesn't match email or password regex or password doesn't match with confirm password
//     if (!emailRegExp.hasMatch(_email) ||
//         !passwordRegExp.hasMatch(_password) ||
//         _password != _confirmPassword
//     ) {
//       _registerNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
//       notifyListeners();
//       return;
//     } 
//     // If matches email and password regex
//     dekhao("_canRegister");
//     _registerNotifier.setSaveStatus(_key, SaveStatus.canSave);
//     notifyListeners();
  
//     if (_password != _confirmPassword) {
//       dekhao("_canRegister false");
//     }
//   }

//   void setEmail(String email) {
//     _email = email;
//     checkCanRegister();
//   }

//   void setPassword(String password) {
//     _password = password.trim();
//     checkCanRegister();
//   }

//   void setConfirmPassword(String password) {
//     _confirmPassword = password.trim();
//     checkCanRegister();
//   }


//   /// Registers user and then save user's basic info.
//   Future<void> registerBang({required VoidCallback onDone}) async {

//     _registerNotifier.setSaveStatus(_key, SaveStatus.saving);

//     await serviceLocator<UserSignUp>().call(
//       UserSignUpParams(email: _email, password: _password)).then((value) {
//         value.fold((l) => null, (r) async {
//           UserAuth userAuth = r;

//           await serviceLocator<SaveUserInfo>().call(
//             UserPrv(
//               id: r.id,
//               email: r.email,
//               country: "",
//               contactNo: "",
//               fullName: r.email,
//               gender: null,
//               birthdate: null,
//               joinedAt: DateTime.now(),
//               imageUrl: null,
//               about: "",)
//             ).then((value) {
//               value.fold((l) {
//                 _registerNotifier.setSaveStatus(_key, SaveStatus.failed); 
//                 Fluttertoast.showToast(msg: "Failed to save user Info.");
//               }, 
//               (r) {
//                 _registerNotifier.setSaveStatus(_key, SaveStatus.success);
//                 onDone();
//               } );
//             });

//           //await serviceLocator<>().call().then((value) => onDone());
//       });
//     });
//   }
// }
