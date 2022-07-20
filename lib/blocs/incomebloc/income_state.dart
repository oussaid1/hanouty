part of 'income_bloc.dart';

enum IncomeStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class IncomesState extends Equatable {
  const IncomesState({
    this.status = IncomeStatus.initial,
    this.incomes = const [],
    this.income,
    this.error,
  });
  final IncomeStatus status;
  final List<IncomeModel> incomes;
  final IncomeModel? income;
  final String? error;
  @override
  List<Object> get props => [status, incomes];
}

// /// Initial state
// class IncomessInitial extends IncomesState {}

// /// Loading state
// class IncomessLoadingState extends IncomesState {}

// /// incomes loaded from database
// class IncomesLoadedState extends IncomesState {
//   final List<IncomeModel> incomes;

//   const IncomesLoadedState(this.incomes);

//   @override
//   List<Object> get props => [incomes];
// }
