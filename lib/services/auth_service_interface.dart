import '../components.dart';
import '../models/login_credentials.dart';

abstract class AuthServiceInterface {
  Future<User> signInWithEmailAndPassword(
      {required LoginCredentials loginCredentials});
  Future<User?> signUpWithEmailAndPassword(
      {required SignUpCredentials signUpCredentials});
  Future<User> signInWithGoogle();

  /// get current user
  Stream<User?> get currentUser;

  /// sign out user
  Future<void> signOut();

  /// check if user is logged in
  bool isLoggedIn();

  /// send password reset email
  Future<void> sendPasswordResetEmail({required String email});
}
