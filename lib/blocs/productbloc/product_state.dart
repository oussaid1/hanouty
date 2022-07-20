part of 'product_bloc.dart';

/// ProductState
enum ProductStatus {
  initial,
  loading,
  loaded,
  updating,
  updated,
  deleting,
  deleted,
  error,
}

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    required this.products,
    this.lastproduct,
    this.error,
  });
  final ProductStatus status;
  final List<ProductModel> products;
  final String? error;
  final ProductModel? lastproduct;

  /// copyWith method
  ProductState copyWith({
    ProductStatus? status,
    List<ProductModel>? products,
    ProductModel? lastproduct,
    String? error,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      lastproduct: lastproduct ?? this.lastproduct,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, products, lastproduct!, error!];
}

// /// Initial state
// class ProductsInitial extends ProductState {}

// /// Loading state
// class ProductsLoadingState extends ProductState {}

// /// products loaded from database
// class ProductsLoadedState extends ProductState {
//   final List<ProductModel> products;

//   const ProductsLoadedState(this.products);

//   @override
//   List<Object> get props => [products];
// }

// /// products successfully added to database
// class ProductAddedState extends ProductState {
//   final ProductModel product;

//   const ProductAddedState(this.product);

//   @override
//   List<Object> get props => [product];
// }

// /// failed to add product to database
// class ProductAddedErrorState extends ProductState {
//   final String error;

//   const ProductAddedErrorState(this.error);

//   @override
//   List<Object> get props => [error];
// }

// /// products successfully updated in database
// class ProductUpdatedState extends ProductState {
//   final ProductModel product;

//   const ProductUpdatedState(this.product);

//   @override
//   List<Object> get props => [product];
// }

// /// failed to update product in database
// class ProductUpdatedErrorState extends ProductState {
//   final String error;

//   const ProductUpdatedErrorState(this.error);

//   @override
//   List<Object> get props => [error];
// }

// /// products successfully deleted from database
// class ProductDeletedState extends ProductState {
//   final ProductModel product;

//   const ProductDeletedState(this.product);

//   @override
//   List<Object> get props => [product];
// }

// /// failed to delete product from database
// class ProductDeletedErrorState extends ProductState {
//   final String error;

//   const ProductDeletedErrorState(this.error);

//   @override
//   List<Object> get props => [error];
// }
