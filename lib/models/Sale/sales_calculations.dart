import 'sale.dart';

class SaleCalculations {
  final List<SaleModel> sales;
  SaleCalculations({
    required this.sales,
  });

  /// get total sales count
  int get totalSalesCount => sales.length;

  /// get total sales amount
  double get totalSalesAmount => sales.fold(
      0, (previousValue, element) => previousValue + element.totalPriceSoldFor);

  /// get total sales amount
  double get totalSalesQuantity => sales.fold(
      0, (previousValue, element) => previousValue + element.quantitySold);

  /// get totalNetProfit
// netProfits that is the difference between the total sold price and the total sold price out
  double get totalNetProfit => sales.fold(
      0, (previousValue, element) => previousValue + element.profitMargin);

  /// get the total price out of all sales
  double get totalSoldPriceOut => sales.fold(
      0, (previousValue, element) => previousValue + element.totalPriceOut);

// total pricein in all sales provided
  double get totalSoldPriceIn => sales.fold(
      0, (previousValue, element) => previousValue + element.totalPriceIn);

// get estimateed net profit by the provided list of sales
  double get estimatedNetProfit {
    return totalSoldPriceOut - totalSoldPriceIn;
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
