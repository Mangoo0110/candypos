// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/common/notifiers/save_status_provider.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../../user/domain/entities/user_prv.dart';
import '../../../user/domain/usecases/save_user_info.dart';
import '../../domain/entities/credentials.dart';
import '../../domain/usecases/user_signin.dart';
import '../../domain/usecases/user_signup.dart';





enum AuthMode { signup, login }

// enum AuthType { provider, userPassword }

/// The callback triggered after login
/// The result is an error message, callback successes if message is null
typedef LoginCallback = Future<String?>? Function(InputCredential);

/// The callback triggered after signup
/// The result is an error message, callback successes if message is null
typedef SignupCallback = Future<String?>? Function(InputCredential);

/// The additional fields are provided as an `HashMap<String, String>`
/// The result is an error message, callback successes if message is null
typedef AdditionalFieldsCallback = Future<String?>? Function(
  Map<String, String>,
);

/// A callback which can be used to check data before switching
/// The result is an error message, callback successes if message is null
typedef BeforeAdditionalFieldsCallback = Future<String?>? Function(InputCredential);

/// If the callback returns true, the additional data card is shown
typedef ProviderNeedsSignUpCallback = Future<bool> Function();

/// The result is an error message, callback successes if message is null
typedef ProviderAuthCallback = Future<String?>? Function();

/// The result is an error message, callback successes if message is null
typedef ProviderDirectCallback = Future? Function();

/// The result is an error message, callback successes if message is null
typedef RecoverCallback = Future<String?>? Function(String);

/// The result is an error message, callback successes if message is null
typedef ConfirmSignupCallback = Future<String?>? Function(String, InputCredential);

typedef ConfirmSignupRequiredCallback = Future<bool> Function(InputCredential);

/// The result is an error message, callback successes if message is null
typedef ConfirmRecoverCallback = Future<String?>? Function(String, InputCredential);

class AuthUiNotifier with ChangeNotifier {

  AuthUiNotifier({
    this.onLogin,
    this.onSignup,
    this.onRecoverPassword,
    String email = '',
    String password = '',
    String confirmPassword = '',
    AuthMode? initialAuthMode,
  })  : _email = email,
        _password = password,
        _confirmPassword = confirmPassword,
        _mode = initialAuthMode ?? AuthMode.login {
          _saveStatusNotifier = SaveStatusNotifier(_key);
        }

  final LoginCallback? onLogin;
  final SignupCallback? onSignup;
  final RecoverCallback? onRecoverPassword;

  final Key _key = Key("AuthUiNotifier_${DateTime.now().toString()}");

  // AuthType _authType = AuthType.userPassword;

  // /// Used to decide if the login/signup comes from a provider or normal login
  // AuthType get authType => _authType;
  // set authType(AuthType authType) {
  //   _authType = authType;
  //   notifyListeners();
  // }


  late SaveStatusNotifier _saveStatusNotifier;
  SaveStatusNotifier get saveStatusNotifier => _saveStatusNotifier;
  void _checkIfCanSave() {
    switch (mode) {

      case AuthMode.login:
        if(AuthEmail.tryParse(_email) != null && _password.isNotEmpty ) {
          if(_saveStatusNotifier.saveStatus != SaveStatus.canSave) _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave); notifyListeners();
        } else {
          if(_saveStatusNotifier.saveStatus != SaveStatus.canNotSave) {
            _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave); notifyListeners();
          }
        }

      case AuthMode.signup:
        if(AuthEmail.tryParse(_email) != null && AuthPassword.tryParse(_password) != null && AuthPassword.tryParse(_confirmPassword) != null && _saveStatusNotifier.saveStatus != SaveStatus.canSave) {
          _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave); notifyListeners();
        } else {
          if(_saveStatusNotifier.saveStatus != SaveStatus.canNotSave) {
            _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave); notifyListeners();
          }
        }
    }
  }


  AuthMode _mode = AuthMode.login;
  AuthMode get mode => _mode;
  set mode(AuthMode value) {
    email = ''; password =''; confirmPassword ='';
    _mode = value;
    notifyListeners();
  }

  bool get isLogin => _mode == AuthMode.login;
  bool get isRegister => _mode == AuthMode.signup;
  int currentCardIndex = 0;

  // AuthMode opposite() {
  //   return _mode == AuthMode.login ? AuthMode.signup : AuthMode.login;
  // }

  /// Login to Register 
  /// 
  /// OR,
  /// 
  ///  Register to Login.
  AuthMode switchAuth() {

    if (mode == AuthMode.login) {
      mode = AuthMode.signup;
      
    } else if (mode == AuthMode.signup) {
      mode = AuthMode.login;
    }
    return mode;

  }

  String _email = '';
  String get email => _email;
  set email(String email) {
    _email = email; _checkIfCanSave();
  }

  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password; _checkIfCanSave();
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String confirmPassword) {
    if(mode != AuthMode.signup) return;
    _confirmPassword = confirmPassword; _checkIfCanSave();
  }


  Future<void> authenticate() async{
    if(_saveStatusNotifier.saveStatus != SaveStatus.canSave) return;

    AuthEmail? authEmail = AuthEmail.tryParse(_email);
    AuthPassword? authPassword;
    if(!isLogin) {
      authPassword = AuthPassword.tryParse(_password);
    } else {
      authPassword = AuthPassword.loginPassword(password);
    }

    if(authEmail == null || authPassword == null) return;
    dekhao("Email and password is not null");
    // _saveStatusNotifier.setSaveStatus(_key, SaveStatus.saving); notifyListeners();

    // return await Future.delayed(Duration(milliseconds: 1750)).then((_){
    //   _saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed); notifyListeners();
    // }).then((_) async{
    //   await Future.delayed(Duration(milliseconds: 1750)).then((_){
    //     _saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave); notifyListeners();
    //   });
    // });

    if(isLogin) {
      await _loginBang(InputCredential(email: authEmail, password: authPassword));
    } else if(isRegister) {
      await _registerBang(InputCredential(email: authEmail, password: authPassword));
    }
  }


  Future<void> _loginBang(InputCredential inputCredential) async{
    _saveStatusNotifier.setSaveStatus(_key,  SaveStatus.saving); 
    await serviceLocator<UserSignIn>().call(inputCredential).then((value) {
      
      value.fold((l) {
        Fluttertoast.showToast(msg: "Login failed!. ${l.message}");
        _saveStatusNotifier.setSaveStatus(_key,  SaveStatus.failed); notifyListeners();

        Future.delayed(Duration(seconds: 1)).then((_) {
          _saveStatusNotifier.setSaveStatus(_key,  SaveStatus.canNotSave); notifyListeners();
        });

        
      }, (r) async{

        Future.delayed(Duration(seconds: 1)).then((_) {
          _saveStatusNotifier.setSaveStatus(_key,  SaveStatus.success); notifyListeners();
          Fluttertoast.showToast(msg: "Welcome.");
        });

      });
      
    });
  }


  /// Registers user and then save user's basic info.
  Future<void> _registerBang(InputCredential inputCredential) async {

    _saveStatusNotifier.setSaveStatus(_key, SaveStatus.saving); notifyListeners();
    

    await serviceLocator<UserSignUp>().call(inputCredential)
    .then((value) {
        value.fold(
          (l) {
            Fluttertoast.showToast(msg: "Failed to register");
            _saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed); notifyListeners();

            Future.delayed(Duration(milliseconds: 300)).then((_) {
              _saveStatusNotifier.setSaveStatus(_key,  SaveStatus.canNotSave); notifyListeners();
            });
          }, 
          (r) async {
            
            await serviceLocator<SaveUserInfo>().call(
              UserPrv(
                id: r.id,
                email: r.email,
                country: "",
                contactNo: "",
                fullName: r.email,
                gender: null,
                birthdate: null,
                joinedAt: DateTime.now(),
                imageUrl: null,
                about: "",)
              ).then((value) {
                value.fold(
                  (l) {

                  }, (r) {
                    Future.delayed(Duration(seconds: 1)).then((_) {
                      _saveStatusNotifier.setSaveStatus(_key,  SaveStatus.success); notifyListeners();
                      Fluttertoast.showToast(msg: "Welcome.");
                    });
                  }
                );
              }
            );
      });
    });
  }

  // Map<String, String>? _additionalSignupData;
  // Map<String, String>? get additionalSignupData => _additionalSignupData;
  // set additionalSignupData(Map<String, String>? additionalSignupData) {
  //   _additionalSignupData = additionalSignupData;
  //   notifyListeners();
  // }
}
