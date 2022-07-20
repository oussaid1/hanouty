part of 'expenses_bloc.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();

  @override
  List<Object> get props => [];
}

///  get expenses from database
class GetExpensesEvent extends ExpensesEvent {}

/// load expenses event
class LoadExpensessEvent extends ExpensesEvent {
  final List<ExpenseModel> expenses;
  const LoadExpensessEvent(this.expenses);
  @override
  List<Object> get props => [expenses];
}

/// add expense to database
class AddExpensesEvent extends ExpensesEvent {
  final ExpenseModel expense;

  const AddExpensesEvent(this.expense);

  @override
  List<Object> get props => [expense];
}

/// Delete expense from database
class DeleteExpensesEvent extends ExpensesEvent {
  final ExpenseModel expense;

  const DeleteExpensesEvent(this.expense);

  @override
  List<Object> get props => [expense];
}

/// Update expense in database
class UpdateExpensesEvent extends ExpensesEvent {
  final ExpenseModel expense;

  const UpdateExpensesEvent(this.expense);

  @override
  List<Object> get props => [expense];
}
