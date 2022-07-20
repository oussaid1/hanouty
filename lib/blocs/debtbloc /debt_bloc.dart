import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
import '../../models/debt/debt.dart';
part 'debt_event.dart';
part 'debt_state.dart';

class DebtsBloc extends Bloc<DebtEvent, DebtsState> {
  /// stream subscription to get the pdebts from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<DebtModel>>? _pdebtsSubscription;
  DebtsBloc({required DatabaseOperations databaseOperations})
      : super(
          const DebtsState(
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
  void _onLoadDebtss(LoadDebtsEvent event, Emitter<DebtsState> emit) async {
    emit(DebtsState(
      status: DebtStatus.loaded,
      debts: event.debts,
      debt: null,
      error: null,
    ));
  }

  /// on get pdebts event
  Future<void> _onGetDebtss(DebtEvent event, Emitter<DebtsState> emit) async {
    // if (_pdebtsSubscription != null) {
    // _pdebtsSubscription!.cancel();
    // }
    _pdebtsSubscription = _databaseOperations
        .debtStream()
        .listen((debts) => add(LoadDebtsEvent(debts)));
  }

  /// on add debt event
  void _onAddDebt(AddDebtEvent event, Emitter<DebtsState> emit) async {
    _databaseOperations.addDebt(event.debt);
    emit(DebtsState(
      status: DebtStatus.added,
      debts: state.debts,
      debt: event.debt,
      error: null,
    ));
    add(GetDebtEvent());
  }

  /// on delete debt event
  void _onDeleteDebt(DeleteDebtEvent event, Emitter<DebtsState> emit) async {
    _databaseOperations.deleteDebt(event.debt);
    emit(DebtsState(
      status: DebtStatus.deleted,
      debts: state.debts,
      debt: event.debt,
      error: null,
    ));
    add(GetDebtEvent());
  }

  /// on update debt event
  void _onUpdateDebt(UpdateDebtEvent event, Emitter<DebtsState> emit) async {
    _databaseOperations.updateDebt(event.debt);
    emit(DebtsState(
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
