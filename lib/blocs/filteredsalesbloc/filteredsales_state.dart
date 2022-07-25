// part of 'filteredsales_bloc.dart';

// class FilteredSalesState extends Equatable {
//   const FilteredSalesState(
//       {required this.filterType, this.dateRange, required this.filteredSales});
//   final DateFilter filterType;
//   final MDateRange? dateRange;
//   final List<SaleModel> filteredSales;

//   /// copyWith() is used to create a new instance of the state.
//   /// It is used to create a new instance of the state when the state changes.
//   FilteredSalesState copyWith({
//     DateFilter? filterType,
//     MDateRange? dateRange,
//     List<SaleModel>? filteredSales,
//   }) {
//     return FilteredSalesState(
//       filterType: filterType ?? this.filterType,
//       dateRange: dateRange ?? this.dateRange,
//       filteredSales: filteredSales ?? this.filteredSales,
//     );
//   }

//   /// toJson() is used to create a new instance of the state.
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     'filterType': filterType.index,
//   //     'dateRange': dateRange?.toJson(),
//   //     'filteredSalesData': filteredSalesData.map((e) => e.toJson()).toList(),
//   //   };
//   // }

//   /// fromJson() is used to create a new instance of the state.
//   // FilteredSalesState.fromJson(Map<String, dynamic> json)
//   //     : filterType = FilterType.values[json['filterType']],
//   //       dateRange = MDateRange.fromJson(json['dateRange']),
//   //       filteredSalesData =
//   //           (json['filteredSalesData'] as List<dynamic>).map((e) => SalesData.fromJson(e)).toList();
//   @override
//   List<Object> get props => [
//         filterType,
//         filteredSales,
//       ];
// }
