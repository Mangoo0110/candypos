
class InputCredential {

  final AuthEmail email;
  final AuthPassword password;

  InputCredential({required this.email, required this.password});


  @override
  String toString() {
    return 'LoginData($email, $password)';
  }

  @override
  bool operator ==(covariant InputCredential other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
  
}


class AuthEmail {
  final String email;

  AuthEmail._({required this.email});

  static AuthEmail? tryParse(String email) {

    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if(!emailRegExp.hasMatch(email)) {
      return null;
    }

    return AuthEmail._(email: email);
  }
}


class AuthPassword {
  final String password;

  AuthPassword._({required this.password});

  factory AuthPassword.loginPassword(String password) => AuthPassword._(password: password);

  static AuthPassword? tryParse(String password) {

    final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
  );

    if(!passwordRegExp.hasMatch(password)) {
      return null;
    }

    return AuthPassword._(password: password);
  }
}