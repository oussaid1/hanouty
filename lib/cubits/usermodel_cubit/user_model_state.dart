part of 'user_model_cubit.dart';

abstract class UserModelState extends Equatable {
  const UserModelState();

  @override
  List<Object> get props => [];
}

/// initial state
class UserModelInitial extends UserModelState {
  final UserModel? user;
  const UserModelInitial({this.user});
  @override
  List<Object> get props => [user!];
}

/// loading state
class UserModelLoading extends UserModelState {}

/// loaded state
class UserModelLoaded extends UserModelState {
  final UserModel user;
  const UserModelLoaded({required this.user});
  @override
  List<Object> get props => [user];
}
