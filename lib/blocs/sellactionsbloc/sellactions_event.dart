part of 'sellactions_bloc.dart';

abstract class SellingactionsEvent extends Equatable {
  const SellingactionsEvent();

  @override
  List<Object> get props => [];
}

/// selling requested event
class SellingRequested extends SellingactionsEvent {
  final SaleModel saleModel;
  final ProductModel productModel;
  int get reducedQuantity => productModel.quantity - saleModel.quantitySold;
  const SellingRequested({required this.saleModel, required this.productModel});

  @override
  List<Object> get props => [saleModel, productModel];
}

// /// selling successful event
// class SellingSuccessful extends SellingactionsEvent {
//   final ProductModel soldProduct;

//   const SellingSuccessful(this.soldProduct);

//   @override
//   List<Object> get props => [soldProduct];
// }

// /// selling failed event
// class SellingFailed extends SellingactionsEvent {
//   final String errorMessage;
//   final ProductModel unsoldProduct;

//   const SellingFailed(this.errorMessage, this.unsoldProduct);

//   @override
//   List<Object> get props => [errorMessage];
// }

/// unselling requested event
class UnsellingRequested extends SellingactionsEvent {
  final SaleModel saleModel;

  const UnsellingRequested({required this.saleModel});

  @override
  List<Object> get props => [saleModel];
}
