part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

///  get incomes from database
class GetIncomeEvent extends IncomeEvent {}

/// load incomes event
class LoadIncomesEvent extends IncomeEvent {
  final List<IncomeModel> incomes;
  const LoadIncomesEvent(this.incomes);
  @override
  List<Object> get props => [incomes];
}

/// add income to database
class AddIncomeEvent extends IncomeEvent {
  final IncomeModel income;

  const AddIncomeEvent(this.income);

  @override
  List<Object> get props => [income];
}

/// Delete income from database
class DeleteIncomeEvent extends IncomeEvent {
  final IncomeModel income;

  const DeleteIncomeEvent(this.income);

  @override
  List<Object> get props => [income];
}

/// Update income in database
class UpdateIncomeEvent extends IncomeEvent {
  final IncomeModel income;

  const UpdateIncomeEvent(this.income);

  @override
  List<Object> get props => [income];
}
