import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/database_operations.dart';
import '../../models/recharge/recharge.dart';

part 'sellactionsrecharge_event.dart';
part 'sellactionsrecharge_state.dart';

class SellActionsRechargeBloc
    extends Bloc<SellActionsrechargeEvent, SellactionsRechargeState> {
  late final DatabaseOperations _databaseOperations;
  SellActionsRechargeBloc({required DatabaseOperations databaseOperations})
      : super(const SellactionsRechargeState(
          status: SellactionsrechargeStatus.initial,
        )) {
    _databaseOperations = databaseOperations;
    on<SellRechargeRequestedEvent>(_onSellRechargeRequested);
    on<UnsellRechargeRequestedEvent>(_onUnsellRechargeRequested);
  }

  /// on Sell Requested
  Future<void> _onSellRechargeRequested(SellRechargeRequestedEvent event,
      Emitter<SellactionsRechargeState> emit) async {
    log('Selling Requested');
    try {
      var success =
          await _databaseOperations.addRechargeSale(event.rechargeSaleModel);
      log('Selling Requested Success: $success');
      if (success) {
        await _databaseOperations.updateRechargeQuantity(
            rechargeId: event.rechargeModel.id!, qntty: event.reducedQuantity);
        emit(SellactionsRechargeState(
          soldRecharge: event.rechargeModel,
          status: SellactionsrechargeStatus.sold,
        ));
      }
    } catch (e) {
      log('Selling Requested Error: $e');
      emit(
        SellactionsRechargeState(
          status: SellactionsrechargeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
    //log('Selling Requested Success');
  }

  /// on unsell requested
  Future<void> _onUnsellRechargeRequested(UnsellRechargeRequestedEvent event,
      Emitter<SellactionsRechargeState> emit) async {
    try {
      bool success =
          await _databaseOperations.deleteRecharge(event.rechargeModel);
      if (success) {
        if (success) {
          await _databaseOperations.updateRechargeQuantity(
              rechargeId: event.rechargeModel.id!,
              qntty:
                  event.rechargeModel.qntt + event.rechargeSaleModel.qnttSld);
          emit(SellactionsRechargeState(
            soldRecharge: event.rechargeModel,
            status: SellactionsrechargeStatus.sold,
          ));
        }
      }
    } catch (e) {
      log('Selling Requested Error: $e');
      emit(
        SellactionsRechargeState(
          status: SellactionsrechargeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
