part of 'fullsales_bloc.dart';

enum FullSalesStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class FullSalesState extends Equatable {
  const FullSalesState(
      {this.status = FullSalesStatus.initial,
      required this.dbSales,
      required this.fullSales,
      required this.products,
      this.error});

  final FullSalesStatus status;
  final List<SaleModel> dbSales;
  final List<SaleModel> fullSales;
  final List<ProductModel> products;
  final String? error;

  /// copyWith() is used to create a new instance of the state.
  FullSalesState copyWith(
      {FullSalesStatus? status,
      List<SaleModel>? dbSales,
      List<ProductModel>? products,
      List<SaleModel>? fullSales,
      String? error}) {
    return FullSalesState(
      status: status ?? this.status,
      dbSales: dbSales ?? this.dbSales,
      fullSales: fullSales ?? this.fullSales,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }

  /// to json is used to create a new instance of the state.
  Map<String, dynamic> toJson() {
    return {
      'status': status.index,
      'dbSales': dbSales,
      'lastsale': products,
      'error': error,
    };
  }

  /// from json is used to create a new instance of the state.
  factory FullSalesState.fromJson(Map<String, dynamic> json) {
    return FullSalesState(
      status: FullSalesStatus.values[json['status']],
      dbSales: json['dbSales'] as List<SaleModel>,
      fullSales: json['lastsale'] as List<SaleModel>,
      products: json['lastsale'] as List<ProductModel>,
      error: json['error'] as String,
    );
  }

  /// toString() is used to print the state in the console.
  @override
  String toString() =>
      'SalesState { status: $status, dbSales: $dbSales,fulllSales: $fullSales, products: $products, error: $error }';

  @override
  List<Object> get props => [status, dbSales, products, fullSales];
}

// /// Initial state
// class SalessInitial extends SalesState {}

// /// Loading state
// class SalessLoadingState extends SalesState {}

// /// dbSales loaded from database
// class SalesLoadedState extends SalesState {
//   final List<SaleModel> dbSales;

//   const SalesLoadedState(this.dbSales);

//   @override
//   List<Object> get props => [dbSales];
// }
