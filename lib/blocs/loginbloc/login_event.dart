part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginCredentialsRreadyEvent extends LoginEvent {
  final LoginCredentials loginCredentials;
  const LoginCredentialsRreadyEvent({required this.loginCredentials});
  @override
  List<Object> get props => [loginCredentials];
}

class LoginRequestedEvent extends LoginEvent {
  final LoginCredentials loginCredentials;
  const LoginRequestedEvent({required this.loginCredentials});
  @override
  List<Object> get props => [loginCredentials];
}

class LogOutRequestedEvent extends LoginEvent {}

class LoginLoadingEvent extends LoginEvent {}

// class LoginUsernameChanged extends LoginEvent {
//   const LoginUsernameChanged(this.username);

//   final String username;

//   @override
//   List<Object> get props => [username];
// }

// class LoginPasswordChanged extends LoginEvent {
//   const LoginPasswordChanged(this.password);

//   final String password;

//   @override
//   List<Object> get props => [password];
// }
