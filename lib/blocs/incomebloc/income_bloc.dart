import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
import '../../models/income/income.dart';
part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomesState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<IncomeModel>>? incomesSubscription;
  IncomeBloc({required DatabaseOperations databaseOperations})
      : super(
          const IncomesState(
            status: IncomeStatus.initial,
            incomes: [],
            income: null,
            error: null,
          ),
        ) {
    _databaseOperations = databaseOperations;

    on<GetIncomeEvent>(_onGetIncomess);

    on<LoadIncomesEvent>(_onLoadIncomess);

    on<AddIncomeEvent>(_onAddIncome);
  }

  /// onloadproducts event
  void _onLoadIncomess(
      LoadIncomesEvent event, Emitter<IncomesState> emit) async {
    emit(IncomesState(
      status: IncomeStatus.loaded,
      incomes: event.incomes,
      income: null,
      error: null,
    ));
  }

  /// on get products event
  Future<void> _onGetIncomess(
      IncomeEvent event, Emitter<IncomesState> emit) async {
    // if (incomesSubscription != null) {
    // incomesSubscription!.cancel();
    // }
    incomesSubscription = _databaseOperations
        .incomeStream()
        .listen((products) => add(LoadIncomesEvent(products)));
  }

  /// on add income event
  void _onAddIncome(AddIncomeEvent event, Emitter<IncomesState> emit) async {
    _databaseOperations.addIncome(event.income);
    emit(IncomesState(
      status: IncomeStatus.added,
      incomes: state.incomes,
      income: event.income,
      error: null,
    ));
  }

  @override
  Future<void> close() {
    incomesSubscription!.cancel();
    return super.close();
  }
}
