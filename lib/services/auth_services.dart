import 'package:hanouty/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Successfully signed in';
    } on FirebaseAuthException catch (e) {
      return '$e';
    }
  }

  Future<UserCredential?> signUp(
      {String? username,
      required String email,
      required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Exception('$e');
      return null;
    }
  }

  Future<void> signout(BuildContext context) async {
    await _firebaseAuth.signOut().then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, '/', ModalRoute.withName('/')));
  }

  static Future<void> pop() async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', true);
  }

  Future resetPass(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Exception(e);
    }
  }
}
