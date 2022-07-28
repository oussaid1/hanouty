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

// products count
  int get productCountInStock {
    int mcount = 0;
    for (var element in products) {
      mcount += (element.count);
    }
    return mcount;
  }

// total product quantity of all items in stock
  int get totalProductQuantityInStock {
    int mcount = 0;
    for (var element in products) {
      mcount += (element.quantity);
    }
    return mcount;
  }

// total product priceIn of all items in stock
  double get totalPriceInInStock {
    double mcount = 0;
    for (var element in products) {
      mcount += (element.priceIn);
    }
    return mcount;
  }

// total product priceOut of all items in stock
  double get totalPriceOutInStock {
    double mcount = 0;
    for (var element in products) {
      mcount += (element.priceOut);
    }
    return mcount;
  }

  /// totalCapitalInStock
  double get totalCapitalInStock {
    double mcount = 0;
    for (var element in products) {
      mcount += (element.priceIn);
    }
    return mcount;
  }

// get a map of distinct categories and their respective products
  Map<String, List<ProductModel>> get distinctCategories {
    Map<String, List<ProductModel>> m = {};
    for (var element in products) {
      if (m[element.category] == null) {
        m[element.category!] = [];
      }
      m[element.category]!.add(element);
    }
    return m;
  }

// get chartData of category counts in stock
  List<ChartData> get prdCatSumCnt {
    List<ChartData> chrtDta = [];
    for (var element in distinctCategories.entries) {
      chrtDta.add(ChartData(
        label: element.key,
        value:
            element.value.fold((0), (sum, element) => sum! + element.priceIn),
        count:
            element.value.fold(0, (pVal, element) => pVal! + element.quantity),
        date: DateTime.now(),
        color: Colors.lightGreen,
      ));
    }
    return chrtDta;
  }
}
