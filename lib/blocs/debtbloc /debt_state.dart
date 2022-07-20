part of 'debt_bloc.dart';

enum DebtStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class DebtsState extends Equatable {
  const DebtsState({
    this.status = DebtStatus.initial,
    this.debts = const [],
    this.debt,
    this.error,
  });
  final DebtStatus status;
  final List<DebtModel> debts;
  final DebtModel? debt;
  final String? error;

  @override
  List<Object> get props => [status, debts];
}


// /// Initial state
// class DebtsInitial extends DebtsState {}

// /// Loading state
// class DebtsLoadingState extends DebtsState {}

// /// debts loaded from database
// class DebtsLoadedState extends DebtsState {
//   final List<DebtModel> debts;

//   const DebtsLoadedState(this.debts);

//   @override
//   List<Object> get props => [debts];
// }

// /// debt added to database
// class DebtAddedState extends DebtsState {}

// /// debt updated in database
// class DebtUpdatedState extends DebtsState {}

// /// debt deleted from database
// class DebtDeletedState extends DebtsState {}

// /// debt error state
// class DebtErrorState extends DebtsState {
//   final String error;

//   const DebtErrorState(this.error);

//   @override
//   List<Object> get props => [error];
// }
