import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
import '../../models/debt/debt.dart';
part 'debt_event.dart';
part 'debt_state.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  /// stream subscription to get the pdebts from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<DebtModel>>? _pdebtsSubscription;
  DebtBloc({required DatabaseOperations databaseOperations})
      : super(
          const DebtState(
            status: DebtStatus.initial,
            debts: [],
            debt: null,
            error: null,
          ),
        ) {
    _databaseOperations = databaseOperations;

    on<GetDebtEvent>(_onGetDebtss);

    on<LoadDebtsEvent>(_onLoadDebtss);

    on<AddDebtEvent>(_onAddDebt);
    on<UpdateDebtEvent>(_onUpdateDebt);
    on<DeleteDebtEvent>(_onDeleteDebt);
  }

  /// onloadpdebts event
  void _onLoadDebtss(LoadDebtsEvent event, Emitter<DebtState> emit) async {
    emit(DebtState(
      status: DebtStatus.loaded,
      debts: event.debts,
      debt: null,
      error: null,
    ));
  }

  /// on get pdebts event
  Future<void> _onGetDebtss(DebtEvent event, Emitter<DebtState> emit) async {
    // if (_pdebtsSubscription != null) {
    // _pdebtsSubscription!.cancel();
    // }
    _pdebtsSubscription = _databaseOperations
        .debtStream()
        .listen((debts) => add(LoadDebtsEvent(debts)));
  }

  /// on add debt event
  void _onAddDebt(AddDebtEvent event, Emitter<DebtState> emit) async {
    var success = await _databaseOperations.addDebt(event.debt);
    log('add debt success: $success');
    if (success) {
      emit(DebtState(
        status: DebtStatus.added,
        debts: state.debts,
        debt: event.debt,
        error: null,
      ));
    } else {
      emit(DebtState(
        status: DebtStatus.notAdded,
        debts: state.debts,
        debt: event.debt,
        error: 'failed to add debt',
      ));
    }
    add(GetDebtEvent());
  }

  /// on delete debt event
  void _onDeleteDebt(DeleteDebtEvent event, Emitter<DebtState> emit) async {
    _databaseOperations.deleteDebt(event.debt);
    emit(DebtState(
      status: DebtStatus.deleted,
      debts: state.debts,
      debt: event.debt,
      error: null,
    ));
    add(GetDebtEvent());
  }

  /// on update debt event
  void _onUpdateDebt(UpdateDebtEvent event, Emitter<DebtState> emit) async {
    _databaseOperations.updateDebt(event.debt);
    emit(DebtState(
      status: DebtStatus.updated,
      debts: state.debts,
      debt: event.debt,
      error: null,
    ));
    add(GetDebtEvent());
  }

  @override
  Future<void> close() {
    _pdebtsSubscription!.cancel();
    return super.close();
  }
}
