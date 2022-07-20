part of 'debt_bloc.dart';

abstract class DebtEvent extends Equatable {
  const DebtEvent();

  @override
  List<Object> get props => [];
}

///  get debts from database
class GetDebtEvent extends DebtEvent {}

/// load debts event
class LoadDebtsEvent extends DebtEvent {
  final List<DebtModel> debts;
  const LoadDebtsEvent(this.debts);
  @override
  List<Object> get props => [debts];
}

/// add debt to database
class AddDebtEvent extends DebtEvent {
  final DebtModel debt;

  const AddDebtEvent(this.debt);

  @override
  List<Object> get props => [debt];
}

/// Delete debt from database
class DeleteDebtEvent extends DebtEvent {
  final DebtModel debt;

  const DeleteDebtEvent(this.debt);

  @override
  List<Object> get props => [debt];
}

/// Update debt in database
class UpdateDebtEvent extends DebtEvent {
  final DebtModel debt;

  const UpdateDebtEvent(this.debt);

  @override
  List<Object> get props => [debt];
}
