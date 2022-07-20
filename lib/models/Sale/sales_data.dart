part of 'sale.dart';

class SalesData {
  List<SaleModel> filteredSales;
  SalesData({
    required this.filteredSales,
  });
  //var loger = Logger();
// get top 10 sales by quantity
  List<SaleModel> get topSales {
    List<SaleModel> topSales = filteredSales;
    topSales.sort((a, b) => b.quantitySold.compareTo(a.quantitySold));
    return topSales.take(10).toList();
  }

// get distinct dates from the provided list
  List<String> get distinctDDMMYY {
    List<String> list = [];
    for (var item in filteredSales) {
      list.add(item.dateSold.ddmmyyyy());
    }
    //loger.d('distinctDDMMYY :${list}');
    list.sort((a, b) => (a.getDate!).compareTo(b.getDate!));
    return list.toSet().toList();
  }

// get distinct dates MMYYY from the provided list
  List<String> get distinctMMYYY {
    List<String> list = [];
    for (var item in filteredSales) {
      list.add(item.dateSold.mmyyyy());
    }
    //loger.d('distinctMMYYY :${list}');
    list.sort((a, b) => (a.getDate!).compareTo(b.getDate!));
    return list.toSet().toList();
  }

// get distinct dates YYYY from the provided list
  List<String> get distinctYYYY {
    List<String> list = [];
    for (var item in filteredSales) {
      list.add(item.dateSold.yyyy());
    }
    //loger.d('distinctYYYY :${list}');
    list.sort((a, b) => (a.getDate!).compareTo(b.getDate!));
    return list.toSet().toList().reversed.toList();
  }

// get a map of tag : list of sales by dd/mm/yyyy
  Map<String, List<SaleModel>> get salesByDDMMYYYY {
    Map<String, List<SaleModel>> map = {};
    for (var item in distinctDDMMYY) {
      map.putIfAbsent(item, () => []);
      map[item]!.addAll(
          filteredSales.where((sale) => sale.dateSold.ddmmyyyy() == item));
    }
    return map;
  }

// get TaggedSales by dd/mm/yyyy
  List<TaggedSales> get taggedSalesByDDMMYYYY {
    List<TaggedSales> list = [];
    for (var item in salesByDDMMYYYY.entries) {
      list.add(TaggedSales(tag: item.key, sales: item.value));
    }
    list.sort((a, b) => b.tag.compareTo(a.tag));
    return list;
  }

// get a map of tag : list of sales by mm/yyyy
  Map<String, List<SaleModel>> get salesByMMYYYY {
    Map<String, List<SaleModel>> map = {};
    for (var item in distinctMMYYY) {
      map.putIfAbsent(item, () => []);
      map[item]!.addAll(
          filteredSales.where((sale) => sale.dateSold.mmyyyy() == item));
    }
    //loger.d('salesByMMYYYY :${map}');
    return map;
  }

// get TaggedSales by mm/yyyy
  List<TaggedSales> get taggedSalesByMMYYYY {
    List<TaggedSales> list = [];
    for (var item in salesByMMYYYY.entries) {
      list.add(TaggedSales(tag: item.key, sales: item.value));
    }
    //loger.d('taggedSalesByMMYYYY :${list}');
    list.sort((a, b) => b.tag.compareTo(a.tag));
    return list;
  }

  // get a map of tag : list of sales by yyyy
  Map<String, List<SaleModel>> get salesByYYYY {
    Map<String, List<SaleModel>> map = {};
    for (var item in distinctYYYY) {
      map.putIfAbsent(item, () => []);
      map[item]!
          .addAll(filteredSales.where((sale) => sale.dateSold.yyyy() == item));
    }
    //loger.d('salesByYYYY :${map}');
    return map;
  }

// get TaggedSales by yyyy
  List<TaggedSales> get taggedSalesByYYYY {
    List<TaggedSales> list = [];
    for (var item in salesByYYYY.entries) {
      list.add(TaggedSales(tag: item.key, sales: item.value));
    }
    // list.sort((a, b) => b.chartData.value!.compareTo(a.chartData.value!));
    list.sort((a, b) => b.tag.compareTo(a.tag));
    return list;
  }

  // maps of the provided list of sales
  List<ChartData> getTopXSalesCountAndValue(int x) {
    List<ChartData> it = [];
    Map<String, dynamic> map2 = {};
    Map<String, dynamic> mapCount = {};
    for (var element in filteredSales) {
      if (!map2.containsKey(element.productSoldName)) {
        mapCount[element.productSoldName] = 1;
        map2[element.productSoldName] = element.totalPriceSoldFor;
      } else {
        mapCount[element.productSoldName] += 1;
        map2[element.productSoldName] += element.totalPriceSoldFor;
      }
    }
    map2.forEach((key, element) {
      //it.add(ChartData(label: key, value: element, count: mapCount[key]));
    });
    it.sort((a, b) => b.value!.compareTo(a.value!));

    return it.length > x ? it.getRange(0, x).toList() : it;
  }
// only data drived from the provided list of sales

  int get totalQuantitySold {
    int count = 0;
    for (var element in filteredSales) {
      count += (element.quantitySold);
    }
    return count;
  }

  /// total sales value for the provided list of sales
  double get totalSoldAmount {
    double total = 0;
    for (var element in filteredSales) {
      total += (element.priceSoldFor);
    }
    return total;
  }

  double get totalSoldPriceOut {
    double count = 0;
    for (var element in filteredSales) {
      count += (element.totalPriceOut);
    }
    return count;
  }

// total pricein in all sales provided
  double get totalSoldPriceIn {
    double count = 0;
    for (var element in filteredSales) {
      count += (element.totalPriceIn);
    }
    return count;
  }

// get estimateed net profit by the provided list of sales
  double get estimatedNetProfit {
    return totalSoldPriceOut - totalSoldPriceIn;
  }

// netProfits that is the difference between the total sold price and the total sold price out
  double get totalNetProfit {
    var count = 0.0;
    for (var element in filteredSales) {
      count += (element.profitMargin);
    }
    return count;
  }

  // get a unit interval of total net profit for the progress indicator
  double get unitNetProfit {
    var unit = 0.0;

    if (estimatedNetProfit > 0) {
      unit = estimatedNetProfit / estimatedNetProfit;

      if (unit > 1 || unit < 0) {
        return unit = 1;
      }
    }
    return unit;
  }
}
