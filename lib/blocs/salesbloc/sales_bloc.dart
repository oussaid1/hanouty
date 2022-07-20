import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
import '../../models/Sale/sale.dart';
part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<SaleModel>>? _productsSubscription;
  SalesBloc({required DatabaseOperations databaseOperations})
      : super(const SalesState(
          status: SalesStatus.initial,
          sales: [],
          lastsale: null,
          error: null,
        )) {
    _databaseOperations = databaseOperations;

    on<GetSalesEvent>(_onGetSaless);

    on<LoadSalessEvent>(_onLoadSaless);

    on<AddSalesEvent>((event, emit) {
      _databaseOperations.addSale(event.sale);
      add(GetSalesEvent());
    });
  }

  /// onloadproducts event
  void _onLoadSaless(LoadSalessEvent event, Emitter<SalesState> emit) async {
    emit(SalesState(
      status: SalesStatus.loading,
      sales: event.sales,
      lastsale: null,
      error: null,
    ));
  }

  /// on get products event
  Future<void> _onGetSaless(SalesEvent event, Emitter<SalesState> emit) async {
    // if (_productsSubscription != null) {
    // _productsSubscription!.cancel();
    // }
    _productsSubscription = _databaseOperations
        .salesStream()
        .listen((products) => add(LoadSalessEvent(products)));
  }

  @override
  Future<void> close() {
    _productsSubscription!.cancel();
    return super.close();
  }
}
