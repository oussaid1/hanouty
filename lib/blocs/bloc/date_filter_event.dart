part of 'date_filter_bloc.dart';

abstract class DateFilterEvent extends Equatable {
  const DateFilterEvent();

  @override
  List<Object> get props => [];
}

/// get DateFilter from [DateFilterEvent]
class GetDateFilter extends DateFilterEvent {
  final DateFilter dateFilter;

  const GetDateFilter({required this.dateFilter});

  @override
  List<Object> get props => [dateFilter];
}
