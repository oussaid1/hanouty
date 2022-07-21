import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hanouty/local_components.dart';
import '../../database/database_operations.dart';
part 'fullsales_event.dart';
part 'fullsales_state.dart';

class FullSalesBloc extends Bloc<FullSalesEvent, FullSalesState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<SaleModel>>? _salesSubscription;
  StreamSubscription<List<ProductModel>>? _productsSubscription;
  FullSalesBloc({required DatabaseOperations databaseOperations})
      : super(const FullSalesState(
          status: FullSalesStatus.initial,
          dbSales: [],
          fullSales: [],
          products: [],
          error: null,
        )) {
    _databaseOperations = databaseOperations;

    on<GetFullSalesEvent>(_onGetSaless);

    on<LoadFullSalessEvent>(_onLoadSaless);

    on<AddFullSalesEvent>(_onAddSales);
  }

  /// onloadproducts event
  void _onLoadSaless(
      LoadFullSalessEvent event, Emitter<FullSalesState> emit) async {
    emit(state.copyWith(
      status: FullSalesStatus.loaded,
      dbSales: event.sales,
      products: event.products,
      fullSales: event.sales.buildSalesList(event.products),
    ));
  }

  /// on get products event
  Future<void> _onGetSaless(
      FullSalesEvent event, Emitter<FullSalesState> emit) async {
    // if (_productsSubscription != null) {
    // _productsSubscription!.cancel();
    // }
    _productsSubscription =
        _databaseOperations.productsStream().listen((products) {
      _salesSubscription = _databaseOperations.salesStream().listen((sales) {
        add(LoadFullSalessEvent(sales, products));
      });
    });
  }

  /// on add product event
  Future<void> _onAddSales(
      AddFullSalesEvent event, Emitter<FullSalesState> emit) async {}

  @override
  Future<void> close() {
    _salesSubscription!.cancel();
    _productsSubscription!.cancel();
    return super.close();
  }
}
