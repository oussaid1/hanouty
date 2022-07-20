import 'dart:async';

import 'package:hanouty/models/expenses/expenses.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<ExpenseModel>>? _expenseSubscription;
  ExpensesBloc({required DatabaseOperations databaseOperations})
      : super(
          const ExpensesState(
            status: ExpensesStatus.initial,
            expenses: [],
            expense: null,
            error: null,
          ),
        ) {
    _databaseOperations = databaseOperations;

    on<GetExpensesEvent>(_onGetExpensess);

    on<LoadExpensessEvent>(_onLoadExpensess);

    on<AddExpensesEvent>(_onAddExpenses);
  }

  /// onloadproducts event
  void _onLoadExpensess(
      LoadExpensessEvent event, Emitter<ExpensesState> emit) async {
    emit(ExpensesState(
      status: ExpensesStatus.loaded,
      expenses: event.expenses,
      expense: null,
      error: null,
    ));
  }

  /// on get products event
  Future<void> _onGetExpensess(
      ExpensesEvent event, Emitter<ExpensesState> emit) async {
    // if (_expenseSubscription != null) {
    // _expenseSubscription!.cancel();
    // }
    _expenseSubscription = _databaseOperations
        .expenseStream()
        .listen((expenses) => add(LoadExpensessEvent(expenses)));
  }

  /// on add Client event
  void _onAddExpenses(
      AddExpensesEvent event, Emitter<ExpensesState> emit) async {
    _databaseOperations.addExpense(event.expense);
    emit(ExpensesState(
      status: ExpensesStatus.added,
      expenses: state.expenses,
      expense: event.expense,
      error: null,
    ));
    add(GetExpensesEvent());
  }

  /// on update product event
  /// on delete product event
  @override
  Future<void> close() {
    _expenseSubscription!.cancel();
    return super.close();
  }
}
