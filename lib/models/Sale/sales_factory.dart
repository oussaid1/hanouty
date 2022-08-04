import 'package:hanouty/blocs/clientsbloc/clients_bloc.dart';

import '../client/shop_client.dart';
import '../suplier/suplier.dart';
import 'sale.dart';

/// a class that takes sales and combines them to suplier and client
class SalesFactory {
  List<SaleModel> sales;
  List<ShopClientModel> clients;
  List<SuplierModel> suppliers;

  SalesFactory({
    required this.sales,
    required this.clients,
    required this.suppliers,
  });
}
