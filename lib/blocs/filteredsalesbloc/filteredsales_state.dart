part of 'filteredsales_bloc.dart';

abstract class FilteredSalesState extends Equatable {
  const FilteredSalesState();
}

class FilteredSalesInitial extends FilteredSalesState {
  @override
  List<Object> get props => [];
}

class FilteredSalesLoadedState extends FilteredSalesState {
  const FilteredSalesLoadedState(
      {required this.filterType,
      this.dateRange,
      required this.filteredSalesData});
  final DateFilter filterType;
  final MDateRange? dateRange;
  final SalesData filteredSalesData;

  /// copyWith() is used to create a new instance of the state.
  /// It is used to create a new instance of the state when the state changes.
  FilteredSalesState copyWith({
    DateFilter? filterType,
    MDateRange? dateRange,
    SalesData? filteredSalesData,
  }) {
    return FilteredSalesLoadedState(
      filterType: filterType ?? this.filterType,
      dateRange: dateRange ?? this.dateRange,
      filteredSalesData: filteredSalesData ?? this.filteredSalesData,
    );
  }

  /// toJson() is used to create a new instance of the state.
  // Map<String, dynamic> toJson() {
  //   return {
  //     'filterType': filterType.index,
  //     'dateRange': dateRange?.toJson(),
  //     'filteredSalesData': filteredSalesData.map((e) => e.toJson()).toList(),
  //   };
  // }

  /// fromJson() is used to create a new instance of the state.
  // FilteredSalesState.fromJson(Map<String, dynamic> json)
  //     : filterType = FilterType.values[json['filterType']],
  //       dateRange = MDateRange.fromJson(json['dateRange']),
  //       filteredSalesData =
  //           (json['filteredSalesData'] as List<dynamic>).map((e) => SalesData.fromJson(e)).toList();
  @override
  List<Object> get props => [filterType, filteredSalesData];
}
