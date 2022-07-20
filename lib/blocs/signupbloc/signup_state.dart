part of 'signup_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

//// initial state of the sign up bloc
class SignupInitial extends SignUpState {}

/// state when the sign up is loading
class SignupLoading extends SignUpState {}

/// state when the sign up is successful
class SignUpSuccessfulState extends SignUpState {
  final User user;
  const SignUpSuccessfulState({required this.user});
  @override
  List<Object> get props => [user];
}

/// state when the sign up is unsuccessful
class SignUpFailureState extends SignUpState {
  final String error;
  const SignUpFailureState({required this.error});
  @override
  List<Object> get props => [error];
}

/// state when the sign up credentials are invalid
class SignupCredentialsInvalid extends SignUpState {}
