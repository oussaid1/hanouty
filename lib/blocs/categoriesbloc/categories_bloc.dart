// import 'dart:async';

// import 'package:hanouty/models/product/product.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../database/database_operations.dart';
// part 'categories_event.dart';
// part 'categories_state.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   /// stream subscription to get the products from the database
//   late final DatabaseOperations _databaseOperations;
//   StreamSubscription<List<ProductModel>>? _productsSubscription;
//   ProductBloc({required DatabaseOperations databaseOperations})
//       : super(ProductsInitial()) {
//     _databaseOperations = databaseOperations;

//     on<GetProductsEvent>(_onGetProducts);

//     on<LoadProductsEvent>(_onLoadProducts);

//     on<AddProductEvent>((event, emit) {
//       _databaseOperations.addProduct(event.product);
//       add(GetProductsEvent());
//     });
//   }

//   /// onloadproducts event
//   void _onLoadProducts(
//       LoadProductsEvent event, Emitter<ProductState> emit) async {
//     emit(ProductsLoadedState(event.products));
//   }

//   /// on get products event
//   Future<void> _onGetProducts(
//       ProductEvent event, Emitter<ProductState> emit) async {
//     // if (_productsSubscription != null) {
//     // _productsSubscription!.cancel();
//     // }
//     _productsSubscription = _databaseOperations
//         .productsStream()
//         .listen((products) => add(LoadProductsEvent(products)));
//   }

//   @override
//   Future<void> close() {
//     _productsSubscription!.cancel();
//     return super.close();
//   }
// }
