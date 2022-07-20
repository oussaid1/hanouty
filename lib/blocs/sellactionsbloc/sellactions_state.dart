part of 'sellactions_bloc.dart';

abstract class SellActionsState extends Equatable {
  const SellActionsState();

  @override
  List<Object> get props => [];
}

/// intial state
class SellactionsInitial extends SellActionsState {}

/// selling state
class SellingState extends SellActionsState {}

/// selling successful state
class SellingSuccessfulState extends SellActionsState {
  final ProductModel soldProduct;

  const SellingSuccessfulState(this.soldProduct);

  @override
  List<Object> get props => [soldProduct];
}

/// selling failed state
class SellingFailedState extends SellActionsState {
  final String errorMessage;
  final ProductModel unsoldProduct;

  const SellingFailedState(this.errorMessage, this.unsoldProduct);

  @override
  List<Object> get props => [errorMessage];
}

/// unselling successfull state
class UnsellingSuccessfulState extends SellActionsState {
  final SaleModel saleModel;

  const UnsellingSuccessfulState(this.saleModel);

  @override
  List<Object> get props => [saleModel];
}

/// unselling failed state
class UnsellingFailedState extends SellActionsState {
  final String errorMessage;
  final SaleModel saleModel;

  const UnsellingFailedState(this.errorMessage, this.saleModel);

  @override
  List<Object> get props => [errorMessage];
}
