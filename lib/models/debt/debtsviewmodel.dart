import '../models.dart';
import '../payment/payment.dart';

class DebtsStatsViewModel {
  DebtsStatsViewModel({
    required this.debts,
    required this.payments,
    required this.shopClients,
    this.filter = DebtFilter.all,
  });

  final List<DebtModel> debts;
  final List<PaymentModel> payments;
  final List<ShopClientModel> shopClients;
  final DebtFilter? filter;

  /// join each client to its debts payments and debts as a list of ShopClientsDeb
  List<ClientDebt> get clientDebts {
    List<ClientDebt> list = [];

    /// join each client to its debts payments and debts as a list of ShopClientsDeb
    /// should prevent shopClients with no debts from being included in the list
    for (final c in shopClients) {
      final d = debts.where((de) => de.clientId == c.id).toList();
      final p = payments.where((pa) => pa.clientId == c.id).toList();
      if (d.isNotEmpty) {
        list.add(ClientDebt(
          shopClient: c,
          debts: d,
          payments: p,
        ));
      }
    }
    return list;
  }

  /// get each client debt total as a list of ChartData
  List<ChartData> get clientDebtTotal {
    List<ChartData> list = [];
    for (var i = 0; i < clientDebts.length; i++) {
      list.add(ChartData(
          label: clientDebts[i].shopClient.clientName,
          value: clientDebts[i].debtData.totalDebtAmountLeft));
    }

    return list;
  }

  /// conver clientsDebts to a list of DebtsStats
}

// class DebtsStats {
//   DebtsStats({
//     required this.shopClient,
//     required this.debts,
//     required this.payments,
//   });

//   final ShopClientModel shopClient;
//   final List<DebtModel> debts;
//   final List<PaymentModel> payments;
// }
