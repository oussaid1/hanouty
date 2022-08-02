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
  SellActionsBloc({required DatabaseOperations databaseOperations})
      : super(const SellActionsState(
          status: SellActionsStatus.initial,
        )) {
    _databaseOperations = databaseOperations;
    on<SellProductRequestedEvent>(_onSellRequested);
    on<UnsellProductRequestedEvent>(_onUnsellRequested);
    on<SellServiceRequestedEvent>(_onSellServiceRequested);
    on<UnsellServiceRequestedEvent>(_onUnsellServiceRequested);
  }

  /// on Sell Requested
  Future<void> _onSellRequested(
      SellProductRequestedEvent event, Emitter<SellActionsState> emit) async {
    log('Selling Requested');
    try {
      var success = await _databaseOperations.addSale(event.saleModel);
      log('Selling Requested Success: $success');
      if (success) {
        await _databaseOperations.updateProductQuantity(
            productId: event.productModel.pId!,
            quantity: event.saleModel.reducedQuantity);

        emit(SellActionsState(
          soldProduct: event.productModel,
          status: SellActionsStatus.sold,
        ));
      }
    } catch (e) {
      log('Selling Requested Error: $e');
      emit(
        SellActionsState(
          status: SellActionsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    //log('Selling Requested Success');
  }

  /// on unsell requested
  Future<void> _onUnsellRequested(
      UnsellProductRequestedEvent event, Emitter<SellActionsState> emit) async {
    try {
      bool success = await _databaseOperations.deleteSale(event.saleModel);
      if (success) {
        await _databaseOperations.updateProductQuantity(
            productId: event.saleModel.pId!,
            quantity: event.saleModel.totalQuantity);
        emit(
          SellActionsState(
            status: SellActionsStatus.unsold,
            soldProduct: event.saleModel,
          ),
        );
      } else {
        emit(
          const SellActionsState(
            status: SellActionsStatus.error,
            errorMessage: 'Unsell Failed',
          ),
        );
      }
    } catch (e) {
      emit(
        SellActionsState(
          status: SellActionsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// on sell service requested
  Future<void> _onSellServiceRequested(
      SellServiceRequestedEvent event, Emitter<SellActionsState> emit) async {
    try {
      bool success = await _databaseOperations.addSale(event.saleModel);
      if (success) {
        emit(
          SellActionsState(
            status: SellActionsStatus.sold,
            soldProduct: event.saleModel,
          ),
        );
      } else {
        emit(
          const SellActionsState(
            status: SellActionsStatus.error,
            errorMessage: 'Sell Service Failed',
          ),
        );
      }
    } catch (e) {
      emit(
        SellActionsState(
          status: SellActionsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// on unsell service requested
  Future<void> _onUnsellServiceRequested(
      UnsellServiceRequestedEvent event, Emitter<SellActionsState> emit) async {
    try {
      bool success = await _databaseOperations.deleteSale(event.saleModel);
      if (success) {
        emit(
          SellActionsState(
            status: SellActionsStatus.unsold,
            soldProduct: event.saleModel,
          ),
        );
      } else {
        emit(
          const SellActionsState(
            status: SellActionsStatus.error,
            errorMessage: 'Unsell Service Failed',
          ),
        );
      }
    } catch (e) {
      emit(
        SellActionsState(
          status: SellActionsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
