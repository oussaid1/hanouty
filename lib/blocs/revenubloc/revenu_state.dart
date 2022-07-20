part of 'revenu_bloc.dart';

abstract class RevenuState extends Equatable {
  const RevenuState();
  
  @override
  List<Object> get props => [];
}

class RevenuInitial extends RevenuState {}
