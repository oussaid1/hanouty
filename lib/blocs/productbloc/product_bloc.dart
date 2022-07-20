import 'dart:async';

import 'package:hanouty/models/product/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<ProductModel>>? _productsSubscription;
  ProductBloc({required DatabaseOperations databaseOperations})
      : super(const ProductState(
          status: ProductStatus.initial,
          products: [],
          lastproduct: null,
          error: null,
        )) {
    _databaseOperations = databaseOperations;

    on<GetProductsEvent>(_onGetProducts);

    on<LoadProductsEvent>(_onLoadProducts);

    on<AddProductEvent>(_onAddProduct);

    on<UpdateProductEvent>(_onUpdateProduct);

    on<DeleteProductEvent>(_onDeleteProduct);
  }

  /// onloadproducts event
  void _onLoadProducts(
      LoadProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductState(
      status: ProductStatus.loading,
      products: event.products,
      lastproduct: null,
      error: null,
    ));
  }

  /// on get products event
  Future<void> _onGetProducts(
      ProductEvent event, Emitter<ProductState> emit) async {
    // if (_productsSubscription != null) {
    // _productsSubscription!.cancel();
    // }
    _productsSubscription = _databaseOperations
        .productsStream()
        .listen((products) => add(LoadProductsEvent(products)));
  }

  /// on add product event
  Future<void> _onAddProduct(
      AddProductEvent event, Emitter<ProductState> emit) async {
    try {
      _databaseOperations.addProduct(event.product);
      emit(ProductState(
        status: ProductStatus.loaded,
        products: state.products,
        lastproduct: event.product,
        error: null,
      ));
      add(GetProductsEvent());
    } catch (e) {
      emit(ProductState(
        status: ProductStatus.error,
        products: state.products,
        lastproduct: event.product,
        error: e.toString(),
      ));
    }
  }

  /// on delete product event
  Future<void> _onDeleteProduct(
      DeleteProductEvent event, Emitter<ProductState> emit) async {
    try {
      _databaseOperations.deleteProduct(event.product);
      emit(ProductState(
        status: ProductStatus.deleted,
        products: state.products,
        lastproduct: event.product,
        error: null,
      ));
      add(GetProductsEvent());
    } catch (e) {
      emit(ProductState(
        status: ProductStatus.error,
        products: state.products,
        lastproduct: event.product,
        error: e.toString(),
      ));
    }
  }

  /// on update product event
  Future<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    try {
      _databaseOperations.updateProduct(event.product);
      emit(ProductState(
        status: ProductStatus.updated,
        products: state.products,
        lastproduct: event.product,
        error: null,
      ));
      add(GetProductsEvent());
    } catch (e) {
      emit(ProductState(
        status: ProductStatus.error,
        products: state.products,
        lastproduct: event.product,
        error: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _productsSubscription!.cancel();
    return super.close();
  }
}
