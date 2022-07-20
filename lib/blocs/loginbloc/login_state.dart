part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginCredentialsInvalidState extends LoginState {
  final LoginCredentials loginCredentials;
  const LoginCredentialsInvalidState({required this.loginCredentials});
}

class LogInSuccessfulState extends LoginState {
  final User user;
  const LogInSuccessfulState({required this.user});
  @override
  List<Object> get props => [user];
}

class LoginFailedState extends LoginState {
  final String error;
  const LoginFailedState({required this.error});
  @override
  List<Object> get props => [error];
}

class LoggedOutState extends LoginState {}

class LogOutFailedState extends LoginState {
  final String error;
  const LogOutFailedState({required this.error});
  @override
  List<Object> get props => [error];
}
