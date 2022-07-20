part of 'sales_bloc.dart';

enum SalesStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class SalesState extends Equatable {
  const SalesState(
      {this.status = SalesStatus.initial,
      required this.sales,
      this.lastsale,
      this.error});

  final SalesStatus status;
  final List<SaleModel> sales;
  final String? error;
  final SaleModel? lastsale;

  /// copyWith() is used to create a new instance of the state.
  SalesState copyWith(
      {SalesStatus? status,
      List<SaleModel>? sales,
      SaleModel? lastsale,
      String? error}) {
    return SalesState(
      status: status ?? this.status,
      sales: sales ?? this.sales,
      lastsale: lastsale ?? this.lastsale,
      error: error ?? this.error,
    );
  }

  /// to json is used to create a new instance of the state.
  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'sales': sales,
      'lastsale': lastsale,
      'error': error,
    };
  }

  /// from json is used to create a new instance of the state.
  factory SalesState.fromJson(Map<String, dynamic> json) {
    return SalesState(
      status: SalesStatus.values[json['status']],
      sales: json['sales'] as List<SaleModel>,
      lastsale: json['lastsale'] as SaleModel,
      error: json['error'] as String,
    );
  }

  /// toString() is used to print the state in the console.

  @override
  List<Object> get props => [status, sales];
}

// /// Initial state
// class SalessInitial extends SalesState {}

// /// Loading state
// class SalessLoadingState extends SalesState {}

// /// sales loaded from database
// class SalesLoadedState extends SalesState {
//   final List<SaleModel> sales;

//   const SalesLoadedState(this.sales);

//   @override
//   List<Object> get props => [sales];
// }
