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
    on<SellingRequestedEvent>(_onSellRequested);
    on<UnsellingRequested>(_onUnsellRequested);
    on<SellServiceRequestedEvent>(_onSellServiceRequested);
    on<UnsellServiceRequestedEvent>(_onUnsellServiceRequested);
  }

  /// on Sell Requested
  Future<void> _onSellRequested(
      SellingRequestedEvent event, Emitter<SellActionsState> emit) async {
    log('Selling Requested');
    try {
      var success = await _databaseOperations.addSale(event.saleModel);
      log('Selling Requested Success: $success');
      if (success) {
        await _databaseOperations.updateProductQuantity(
            productId: event.productModel.pId!,
            quantity: event.saleModel.reducedQuantity);

        emit(SellingSuccessfulState(event.productModel));
      }
    } catch (e) {
      log('Selling Requested Error: $e');
      emit(SellingFailedState(e.toString(), event.productModel));
    }
    //log('Selling Requested Success');
  }

  /// on unsell requested
  Future<void> _onUnsellRequested(
      UnsellingRequested event, Emitter<SellActionsState> emit) async {
    try {
      bool success = await _databaseOperations.deleteSale(event.saleModel);
      if (success) {
        await _databaseOperations.updateProductQuantity(
            productId: event.saleModel.pId!,
            quantity: event.saleModel.totalQuantity);
        emit(UnsellingSuccessfulState(event.saleModel));
      } else {
        emit(UnsellingFailedState('Unselling Failed', event.saleModel));
      }
    } catch (e) {
      emit(UnsellingFailedState(e.toString(), event.saleModel));
    }
  }

  /// on sell service requested
  Future<void> _onSellServiceRequested(
      SellServiceRequestedEvent event, Emitter<SellActionsState> emit) async {
    try {
      bool success = await _databaseOperations.addSale(event.saleModel);
      if (success) {
        emit(SellingSuccessfulState(event.saleModel));
      } else {
        emit(SellingFailedState('Selling Failed', event.saleModel));
      }
    } catch (e) {
      emit(SellingFailedState(e.toString(), event.saleModel));
    }
  }

  /// on unsell service requested
  Future<void> _onUnsellServiceRequested(
      UnsellServiceRequestedEvent event, Emitter<SellActionsState> emit) async {
    try {
      bool success = await _databaseOperations.deleteSale(event.saleModel);
      if (success) {
        emit(UnsellingSuccessfulState(event.saleModel));
      } else {
        emit(UnsellingFailedState('Unselling Failed', event.saleModel));
      }
    } catch (e) {
      emit(UnsellingFailedState(e.toString(), event.saleModel));
    }
  }
}
