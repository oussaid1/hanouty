part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitialEvent extends AuthEvent {}

class AuthLoadingEvent extends AuthEvent {}

class AuthSuccessfulEvent extends AuthEvent {
  final User? user;
  const AuthSuccessfulEvent({this.user});
  @override
  List<Object> get props => [user!];
}

class AuthFailedEvent extends AuthEvent {
  final String error;
  const AuthFailedEvent({required this.error});
  @override
  List<Object> get props => [error];
}

class NotAuthenticatedEvent extends AuthEvent {}
