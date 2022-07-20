part of 'sales_bloc.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object> get props => [];
}

///  get sales from database
class GetSalesEvent extends SalesEvent {}

/// load sales event
class LoadSalessEvent extends SalesEvent {
  final List<SaleModel> sales;
  const LoadSalessEvent(this.sales);
  @override
  List<Object> get props => [sales];
}

/// add sale to database
class AddSalesEvent extends SalesEvent {
  final SaleModel sale;

  const AddSalesEvent(this.sale);

  @override
  List<Object> get props => [sale];
}

/// Delete sale from database
class DeleteSalesEvent extends SalesEvent {
  final SaleModel sale;

  const DeleteSalesEvent(this.sale);

  @override
  List<Object> get props => [sale];
}

/// Update sale in database
class UpdateSalesEvent extends SalesEvent {
  final SaleModel sale;

  const UpdateSalesEvent(this.sale);

  @override
  List<Object> get props => [sale];
}
