part of 'expenses_bloc.dart';

enum ExpensesStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class ExpensesState extends Equatable {
  const ExpensesState({
    this.status = ExpensesStatus.initial,
    this.expenses = const [],
    this.expense,
    this.error,
  });
  final ExpensesStatus status;
  final List<ExpenseModel> expenses;
  final ExpenseModel? expense;
  final String? error;

  @override
  List<Object> get props => [status, expenses, expense!, error!];
}

// /// Initial state
// class ExpensessInitial extends ExpensesState {}

// /// Loading state
// class ExpensessLoadingState extends ExpensesState {}

// /// expenses loaded from database
// class ExpensesLoadedState extends ExpensesState {
//   final List<ExpenseModel> expenses;

//   const ExpensesLoadedState(this.expenses);

//   @override
//   List<Object> get props => [expenses];
// }

// /// expense added to database
// class ExpenseAddedState extends ExpensesState {}

// /// expense updated in database
// class ExpenseUpdatedState extends ExpensesState {}

// /// expense deleted from database
// class ExpenseDeletedState extends ExpensesState {}

// /// expense error state
// class ExpenseErrorState extends ExpensesState {
//   final String error;

//   const ExpenseErrorState(this.error);

//   @override
//   List<Object> get props => [error];
// }
