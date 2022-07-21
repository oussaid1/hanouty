import 'dart:developer';

import 'package:hanouty/database/database_operations.dart';
import 'package:hanouty/models/Sale/sale.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product/product.dart';

part 'sellactions_event.dart';
part 'sellactions_state.dart';

class SellActionsBloc extends Bloc<SellingactionsEvent, SellActionsState> {
  late final DatabaseOperations _databaseOperations;
  SellActionsBloc(DatabaseOperations dbOp) : super(SellactionsInitial()) {
    _databaseOperations = dbOp;
    on<SellingRequested>(_onSellRequested);
    on<UnsellingRequested>(_onUnsellRequested);
  }

  /// on Sell Requested
  Future<void> _onSellRequested(
      SellingRequested event, Emitter<SellActionsState> emit) async {
    log('Selling Requested');
    try {
      await _databaseOperations.addSale(event.saleModel);
      await _databaseOperations.updateProduct(event.productModel.copyWith(
        quantity: event.reducedQuantity,
      ));
      emit(SellingSuccessfulState(event.productModel));
      log('Selling Requested Success');
    } catch (e) {
      emit(SellingFailedState(e.toString(), event.saleModel));
    }
  }

  /// on unsell requested
  Future<void> _onUnsellRequested(
      UnsellingRequested event, Emitter<SellActionsState> emit) async {
    try {
      await _databaseOperations.deleteSale(event.saleModel);
      await _databaseOperations.updateProduct(event.saleModel);
      emit(UnsellingSuccessfulState(event.saleModel));
    } catch (e) {
      emit(UnsellingFailedState(e.toString(), event.saleModel));
    }
  }
}
