import 'product.dart';

class ProductCalculations {
  final List<ProductModel> products;
  ProductCalculations({
    required this.products,
  });

  // get produsts by quantity less than int value
  List<ProductModel> getProductsLessThan(int quantity) {
    return products.where((product) => product.quantity <= quantity).toList();
  }

  // products count

  int get productCountInStock => products.length;

  /// total product quantity of all items in stock
  int get totalProductQuantityInStock =>
      products.fold(0, (sum, element) => sum + element.quantity);

  /// total product priceIn of all items in stock
  double get totalPriceInInStock =>
      products.fold(0, (sum, element) => sum + element.priceIn);

  /// total product priceOut of all items in stock
  double get totalPriceOutInStock =>
      products.fold(0, (sum, element) => sum + element.priceOut);

  /// totalCapitalInStock
  double get totalCapitalInStock =>
      products.fold(0, (sum, element) => sum + element.priceIn);
}
