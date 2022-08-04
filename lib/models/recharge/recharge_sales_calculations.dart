import 'recharge.dart';

class RechargeSalesCalculations {
  List<RechargeSaleModel> allRechargeSales = [];
  RechargeSalesCalculations({
    required this.allRechargeSales,
  });

/////////////////////////////////////////////////////////////////////////////
//// sums  ////////////////////////////////////////////////////
  /// the total amount of recharge sales [without percentage calculation] just quantity * price
  double get totalRechargeAmntWqnttInStock =>
      allRechargeSales.fold(0.0, (sum, e) => sum + e.totalAmount);

  /// total of card amount times the quqntity sold
  double get totalRechargeAmntWqnttSoldInSales =>
      allRechargeSales.fold(0.0, (sum, e) => sum + e.amount * e.qnttSld);

  /// the total amount of recharge sales [without percentage calculation] just  amount
  double get totalRechargeAmntNoQntt =>
      allRechargeSales.fold(0.0, (sum, e) => sum + e.amount);

  /// total of quantity of recharge sales
  num get totalRechargeQnttSold =>
      allRechargeSales.fold(0, (sum, e) => sum + e.qnttSld);

  /// total pf percentage of recharge sales
  num get totalRechargePrcnt =>
      allRechargeSales.fold(0, (sum, e) => sum + e.percntg);

  /// total of recharge sales [with percentage calculation]
  double get totalRechargeNetProfitNoQntt =>
      allRechargeSales.fold(0.0, (sum, e) => sum + e.netProfit);

  /// total of recharge sales [with percentage calculation]
  double get totalRechargeNetProfit =>
      allRechargeSales.fold(0.0, (sum, e) => sum + e.netProfit * e.qnttSld);
}
