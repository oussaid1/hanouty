part of 'filteredsales_bloc.dart';

class FilteredSalesEvent extends Equatable {
  const FilteredSalesEvent();
  @override
  List<Object> get props => [];
}

class GetFilteredSaleDataEvent extends FilteredSalesEvent {
  final DateFilter filterType;
  const GetFilteredSaleDataEvent(this.filterType);
  @override
  List<Object> get props => [filterType];
}

/// initial event is used to initialize the state.
class LoadFilteredSalesEvent extends FilteredSalesEvent {
  final DateFilter filterType;
  final MDateRange? dateRange;
  final FilteredSales filteredSales;
  const LoadFilteredSalesEvent(
      {required this.filterType, this.dateRange, required this.filteredSales});
  @override
  List<Object> get props => [filterType, filteredSales];
}

/// FilterSales By All , Month , week .....except custom
class FilterSalesAutoState extends FilteredSalesEvent {
  final DateFilter filterType;

  const FilterSalesAutoState({
    required this.filterType,
  });
  @override
  List<Object> get props => [filterType];
}

/// FilterSales By Custom Date Range
class FilterSalesByCustomEvent extends FilteredSalesEvent {
  final DateFilter filterType;
  final MDateRange dateRange;
  const FilterSalesByCustomEvent({
    required this.filterType,
    required this.dateRange,
  });
  @override
  List<Object> get props => [filterType, dateRange];
}
