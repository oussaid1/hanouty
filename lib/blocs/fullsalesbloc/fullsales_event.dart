part of 'fullsales_bloc.dart';

abstract class FullSalesEvent extends Equatable {
  const FullSalesEvent();

  @override
  List<Object> get props => [];
}

///  get sales from database
class GetFullSalesEvent extends FullSalesEvent {}

/// load sales event
class LoadFullSalessEvent extends FullSalesEvent {
  final List<SaleModel> sales;
  final List<ProductModel> products;

  const LoadFullSalessEvent(this.sales, this.products);
  @override
  List<Object> get props => [sales, products];
}

/// add sale to database
class AddFullSalesEvent extends FullSalesEvent {
  final SaleModel sale;

  const AddFullSalesEvent(this.sale);

  @override
  List<Object> get props => [sale];
}

/// Delete sale from database
class DeleteFullSalesEvent extends FullSalesEvent {
  final SaleModel sale;
  final int index;

  const DeleteFullSalesEvent(this.sale, this.index);

  @override
  List<Object> get props => [sale];
}

/// Update sale in database
class UpdateSalesEvent extends FullSalesEvent {
  final SaleModel sale;
  final int index;

  const UpdateSalesEvent(this.sale, this.index);

  @override
  List<Object> get props => [sale];
}
