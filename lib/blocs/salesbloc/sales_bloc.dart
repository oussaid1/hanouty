import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
import '../../models/Sale/sale.dart';
part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<SaleModel>>? _salesSubscription;
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

    on<AddSalesEvent>(_onAddSales);
  }

  /// onloadproducts event
  void _onLoadSaless(LoadSalessEvent event, Emitter<SalesState> emit) async {
    emit(state.copyWith(status: SalesStatus.loaded, sales: event.sales));
  }

  /// on get products event
  Future<void> _onGetSaless(SalesEvent event, Emitter<SalesState> emit) async {
    // if (_productsSubscription != null) {
    // _productsSubscription!.cancel();
    // }
    _salesSubscription = _databaseOperations.salesStream().listen((sales) {
      log('sales: ${sales.length}');
      add(LoadSalessEvent(sales));
    });
  }

  /// on add product event
  Future<void> _onAddSales(
      AddSalesEvent event, Emitter<SalesState> emit) async {
    try {
      _databaseOperations.addSale(event.sale);
      emit(state.copyWith(
        status: SalesStatus.added,
        sales: state.sales,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SalesStatus.error,
        error: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _salesSubscription!.cancel();
    return super.close();
  }
}
