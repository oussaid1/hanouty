part of 'product.dart';

class ProductStockData {
  List<ProductModel> products;
  ProductStockData({
    required this.products,
  });
// get produsts by quantity less than int value
  List<ProductModel> getProductsLessThan(int quantity) {
    return products.where((product) => product.quantity <= quantity).toList();
  }

// get a map of distinct categories and their respective products
  List<String> get distinctCategories =>
      products.map((product) => product.category!).toSet().toList();

// get chartData of category counts in stock
  List<TaggedProducts> get productDataByCategory => distinctCategories
      .map((category) => TaggedProducts(
            tag: category,
            products: products
                .where((product) => product.category == category)
                .toList(),
          ))
      .toList();
}
