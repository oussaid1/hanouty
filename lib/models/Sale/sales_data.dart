part of 'sale.dart';

class SalesData {
  //sortedSales sortedSales;
  List<SaleModel> sales;
  SalesData({
    //required this.sortedSales,
    required this.sales,
  });
////////////////////////////////////////////
  /// all sales where type is product
  List<SaleModel> get productSalesList =>
      sales.where((element) => element.type == SaleType.product).toList();

  /// count of product sales
  int get productSalesCount => productSalesList.length;

  /// all sales where type is service
  List<SaleModel> get serviceSalesList =>
      sales.where((element) => element.type == SaleType.service).toList();

  /// count of service sales
  int get serviceSalesCount => serviceSalesList.length;
//////////////////////////////////////
  // get filtered sales
  // @returns List<SaleModel>
  List<SaleModel> get sortedSales {
    return sales.toList()..sort((a, b) => b.dateSold.compareTo(a.dateSold));
  }

  ProductSalesData get productSalesData =>
      ProductSalesData(sales: productSalesList);
  TechServiceSalesData get serviceSalesData =>
      TechServiceSalesData(sales: serviceSalesList);
  //var loger = Logger();
// get top 10 sales by quantity
  List<SaleModel> get topSales {
    sortedSales.sort((a, b) => b.quantitySold.compareTo(a.quantitySold));
    return topSales.take(10).toList();
  }
//////////////////////////////////////////////////////////////////////////////////////
  ///Distincts from the list of sales /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
  List<String> get distinctCilentNames {
    List<String> mlist = [];
    for (var element in sales) {
      mlist.add(element.shopClientId);
    }
    return mlist.toSet().toList();
  }

  /// distinct categories
  List<String> get distinctCategories {
    List<String> mlist = [];
    for (var element in sales) {
      mlist.add(element.category!);
    }
    return mlist.toSet().toList();
  }

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
  /// a map of sles by category
  List<TaggedSales> get salesByCategory {
    Map<String, List<SaleModel>> map = {};
    for (var category in distinctCategories) {
      map.putIfAbsent(category, () => []);
      map[category]!.addAll(sortedSales
          .where((element) => element.category! == category)
          .toList());
    }
    //loger.d('salesByCategory :${map}');
    var lst = map.entries
        .map((entry) => TaggedSales(tag: entry.key, sales: entry.value))
        .toList();
    //lst.sort((a, b) => b.length.compareTo(a.length));
    return lst;
  }

  /// a map of sles by Supplier
  List<TaggedSales> get salesBySupplier {
    Map<String, List<SaleModel>> map = {};
    for (var sale in sales) {
      map.putIfAbsent(sale.suplier!, () => []);
      map[sale.suplier]!.addAll(sortedSales
          .where((element) => element.suplier! == sale.suplier!)
          .toList());
    }
    //loger.d('salesByCategory :${map}');
    var lst = map.entries
        .map((entry) => TaggedSales(tag: entry.key, sales: entry.value))
        .toList();
    //lst.sort((a, b) => b.length.compareTo(a.length));
    return lst;
  }

  /// get a list of sales sorted by date in
  List<ProductModel> get sortedsales {
    return sales.toList()..sort((a, b) => a.dateIn.compareTo(b.dateIn));
  }

  /// get a map of sum of sales prices for each day
  /// key is date in, value is sum of prices in
  Map<DateTime, double> get pricesByDay {
    Map<DateTime, double> pricesByDay = {};
    for (ProductModel product in sortedsales) {
      pricesByDay[product.dateIn] ??= 0.0;
      pricesByDay[product.dateIn] =
          pricesByDay[product.dateIn]! + product.priceIn;
    }
    return pricesByDay;
  }

  /// get a map of sum of sales prices for each month
  /// key is month in, value is sum of prices in
  Map<DateTime, double> get pricesByMonth {
    Map<DateTime, double> pricesByMonth = {};
    for (ProductModel product in sortedsales) {
      pricesByMonth[DateTime(00, product.dateIn.month, product.dateIn.year)] ??=
          0.0;
      pricesByMonth[DateTime(00, product.dateIn.month, product.dateIn.year)] =
          pricesByMonth[
                  DateTime(00, product.dateIn.month, product.dateIn.year)]! +
              product.priceIn;
    }
    return pricesByMonth;
  }

  /// get a map of sum of sales prices for each year
  /// key is year in, value is sum of prices in
  Map<DateTime, double> get pricesByYear {
    Map<DateTime, double> pricesByYear = {};
    for (ProductModel product in sortedsales) {
      pricesByYear[DateTime(product.dateIn.year, 00, 00)] ??= 0.0;
      pricesByYear[DateTime(product.dateIn.year, 00, 00)] =
          pricesByYear[DateTime(product.dateIn.year, 00, 00)]! +
              product.priceIn;
    }
    return pricesByYear;
  }

  /// get a list of ChartData for each day
  List<ChartData> get chartDataDDMMYY {
    return pricesByDay.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a list of ChartData for each month
  List<ChartData> get chartDataMMYY {
    return pricesByMonth.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a list of ChartData for each year
  /// key is year in, value is sum of prices in
  List<ChartData> get chartDataYY {
    return pricesByYear.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a list of ChartData for each year
  /// key is year in, value is sum of prices in
  List<ChartData> get chartDataYYMMDD {
    return pricesByYear.entries.map((entry) {
      return ChartData(
          label: entry.key.toString(), value: entry.value, date: entry.key);
    }).toList();
  }

  /// get a map of sum of sales prices for category
  /// key is category, value is sum of prices in
  Map<String, double> get pricesByCategory {
    Map<String, double> pricesByCategory = {};
    for (ProductModel product in sortedsales) {
      pricesByCategory[product.category!] ??= 0.0;
      pricesByCategory[product.category!] =
          pricesByCategory[product.category]! + product.priceIn;
    }
    return pricesByCategory;
  }

  // /// get a list of ChartData from a map parameter
  // List<ChartData> chartData(map) {
  //   return map.map((entry) {
  //     return ChartData(entry.key, entry.value, DateTime.now());
  //   }).toList();
  // }

  /// get a list of ChartData from categoryies
  List<ChartData> get chartDataByCategory {
    return pricesByCategory.entries.map((entry) {
      return ChartData(label: entry.key.toString(), value: entry.value);
    }).toList();
  }
}
