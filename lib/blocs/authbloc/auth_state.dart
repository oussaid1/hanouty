part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Initial state of the auth bloc.
class AuthInitState extends AuthState {}

/// State of the auth bloc when the user is authenticating.
class AthenticatingState extends AuthState {}

/// State of the auth bloc when the user is authenticated.
class AuthenticatedState extends AuthState {
  final User user;
  const AuthenticatedState({required this.user});
  @override
  List<Object> get props => [user];
}

/// State of the auth bloc when the user is failed to authenticate.
class AuthenticationFailedState extends AuthState {
  final String error;
  const AuthenticationFailedState({required this.error});
  @override
  List<Object> get props => [error];
}

/// State of the auth bloc when the user is unauthenticated.
class UnauthenticatedState extends AuthState {}
