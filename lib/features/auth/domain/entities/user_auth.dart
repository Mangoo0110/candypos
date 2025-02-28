
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserAuth extends ChangeNotifier{

  static UserAuth? _instance; 


  static UserAuth? get instance {
    return _instance!;
  }
  
  final String id;

  final String email;

  final bool emailVerified;

  UserAuth._({
    required this.id,
    required this.email,
    required this.emailVerified,
  });


  factory UserAuth.fromFirebaseAuthUser({
    required User currentUser
  }) {
    return UserAuth._(id: currentUser.uid, email: currentUser.email ?? '', emailVerified: currentUser.emailVerified);
  }



  @override
  String toString() => 'UserAuth(id: $id, email: $email, emailVerified: $emailVerified)';

  @override
  bool operator ==(covariant UserAuth other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.email == email &&
      other.emailVerified == emailVerified;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ emailVerified.hashCode;
}