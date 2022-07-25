part of 'date_filter_bloc.dart';

abstract class DateFilterState extends Equatable {
  const DateFilterState();
  
  @override
  List<Object> get props => [];
}

class DateFilterInitial extends DateFilterState {}
