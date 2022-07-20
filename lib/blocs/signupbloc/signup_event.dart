part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequestedEvent extends SignupEvent {
  final SignUpCredentials signUpCredentials;
  const SignUpRequestedEvent({required this.signUpCredentials});
  @override
  List<Object> get props => [signUpCredentials];
}

class SignUpRequestedWithEmailEvent extends SignupEvent {
  final String username;
  final String email;
  final String password;
  const SignUpRequestedWithEmailEvent({
    required this.username,
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [
        username,
        email,
        password,
      ];
}
