part of 'sellactions_bloc.dart';

abstract class SellingactionsEvent extends Equatable {
  const SellingactionsEvent();

  @override
  List<Object> get props => [];
}

/// selling requested event
class SellProductRequestedEvent extends SellingactionsEvent {
  final SaleModel saleModel;
  final ProductModel productModel;
  int get reducedQuantity => productModel.quantity - saleModel.quantitySold;
  const SellProductRequestedEvent(
      {required this.saleModel, required this.productModel});

  @override
  List<Object> get props => [saleModel, productModel];
}

class SellServiceRequestedEvent extends SellingactionsEvent {
  final SaleModel saleModel;

  const SellServiceRequestedEvent({required this.saleModel});

  @override
  List<Object> get props => [saleModel];
}

/// unselling service requested event
class UnsellServiceRequestedEvent extends SellingactionsEvent {
  final SaleModel saleModel;
  const UnsellServiceRequestedEvent({required this.saleModel});
  @override
  List<Object> get props => [saleModel];
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
class UnsellProductRequestedEvent extends SellingactionsEvent {
  final SaleModel saleModel;

  const UnsellProductRequestedEvent({required this.saleModel});

  @override
  List<Object> get props => [saleModel];
}
