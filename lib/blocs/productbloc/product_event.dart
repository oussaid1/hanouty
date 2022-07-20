part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

///  get products from database
class GetProductsEvent extends ProductEvent {}

/// load products event
class LoadProductsEvent extends ProductEvent {
  final List<ProductModel> products;
  const LoadProductsEvent(this.products);
  @override
  List<Object> get props => [products];
}

/// add product to database
class AddProductEvent extends ProductEvent {
  final ProductModel product;

  const AddProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

/// Delete product from database
class DeleteProductEvent extends ProductEvent {
  final ProductModel product;

  const DeleteProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

/// Update product in database
class UpdateProductEvent extends ProductEvent {
  final ProductModel product;

  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
