import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hanouty/models/recharge/recharge.dart';

import 'package:hanouty/models/user/user_model.dart';

import 'package:hanouty/models/techservice/techservice.dart';

import 'package:hanouty/models/suplier/suplier.dart';

import 'package:hanouty/models/product/product.dart';

import 'package:hanouty/models/payment/payment.dart';

import 'package:hanouty/models/income/income.dart';

import 'package:hanouty/models/expenses/expenses.dart';

import 'package:hanouty/models/debt/debt.dart';

import 'package:hanouty/models/client/shop_client.dart';

import 'package:hanouty/models/Sale/sale.dart';

import 'database.dart';

class DatabaseOperations implements Database {
  final Database _database;
  DatabaseOperations(this._database);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////ADD / CREATE ///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<bool> addClient(ShopClientModel client) {
    return _database.addClient(client);
  }

  @override
  Future<bool> addDebt(DebtModel debt) => _database.addDebt(debt);

  @override
  Future<bool> addExpense(ExpenseModel expense) =>
      _database.addExpense(expense);

  @override
  Future<bool> addIncome(IncomeModel income) => _database.addIncome(income);

  @override
  Future<bool> addPayment(PaymentModel payment) =>
      _database.addPayment(payment);

  @override
  Future<bool> addProduct(ProductModel product) =>
      _database.addProduct(product);

  @override
  Future<bool> addSale(SaleModel sale) => _database.addSale(sale);

  @override
  Future<bool> addTechService(TechServiceModel techService) =>
      _database.addTechService(techService);

  @override
  Future<bool> addSuplier(SuplierModel suplier) =>
      _database.addSuplier(suplier);

  @override
  Future<bool> createUser(UserModel user) => _database.createUser(user);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////GET ///////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Future<ProductModel> getOneproduct(String id) => _database.getOneproduct(id);

  @override
  Future<ProductModel> getProductById(String id) =>
      _database.getProductById(id);
  @override
  Stream<List<ShopClientModel>> clientsStream() => _database.clientsStream();

  @override
  Stream<List<DebtModel>> debtStream() => _database.debtStream();

  @override
  Stream<List<ExpenseModel>> expenseStream() => _database.expenseStream();

  @override
  Stream<List<IncomeModel>> incomeStream() => _database.incomeStream();

  @override
  Stream<List<PaymentModel>> paymentStream() => _database.paymentStream();

  @override
  Stream<List<ProductModel>> productsStream() => _database.productsStream();

  @override
  Stream<List<SaleModel>> salesStream() => _database.salesStream();

  @override
  Stream<List<TechServiceModel>> techServiceStream() =>
      _database.techServiceStream();

  @override
  Stream<List<SuplierModel>> supliersStream() => _database.supliersStream();

  @override
  Future<UserModel?> getUser() => _database.getUser();

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////REMOVE //////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<bool> deleteClient(ShopClientModel client) =>
      _database.deleteClient(client);

  @override
  Future<bool> deleteDebt(DebtModel debt) => _database.deleteDebt(debt);

  @override
  Future<bool> deleteExpense(ExpenseModel expense) =>
      _database.deleteExpense(expense);

  @override
  Future<bool> deleteIncome(IncomeModel income) =>
      _database.deleteIncome(income);

  @override
  Future<bool> deletePayment(PaymentModel payment) =>
      _database.deletePayment(payment);

  @override
  Future<bool> deleteProduct(ProductModel product) =>
      _database.deleteProduct(product);

  @override
  Future<bool> deleteSale(SaleModel sale) => _database.deleteSale(sale);

  @override
  Future<bool> deleteTechService(TechServiceModel techService) =>
      _database.deleteTechService(techService);

  @override
  Future<bool> deleteSuplier(SuplierModel suplier) =>
      _database.deleteSuplier(suplier);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////UPDATE //////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<bool> updateClient(ShopClientModel client) =>
      _database.updateClient(client);

  @override
  Future<bool> updateDebt(DebtModel debt) => _database.updateDebt(debt);

  @override
  Future<bool> updateExpense(ExpenseModel expense) =>
      _database.updateExpense(expense);

  @override
  Future<bool> updateIncome(IncomeModel income) =>
      _database.updateIncome(income);

  @override
  Future<bool> updatePayment(PaymentModel payment) =>
      _database.updatePayment(payment);

  @override
  Future<bool> updateProduct(ProductModel product) =>
      _database.updateProduct(product);

  @override
  Future<bool> updateSale(SaleModel sale) => _database.updateSale(sale);

  @override
  Future<bool> updateTechService(TechServiceModel techService) =>
      _database.updateTechService(techService);

  @override
  Future<bool> updateSuplier(SuplierModel suplier) =>
      _database.updateSuplier(suplier);

  @override
  Future<bool> updateUser(UserModel user) => _database.updateUser(user);

  @override
  String? uid;

  @override
  void setUserUid(String uid) {
    this.uid = uid;
  }

  @override
  CollectionReference<Object?> get users => _database.users;

  @override
  Future<bool> updateProductQuantity(
          {required String productId, required int quantity}) =>
      _database.updateProductQuantity(productId: productId, quantity: quantity);

  @override
  Future<bool> addRecharge(RechargeModel recharge) =>
      _database.addRecharge(recharge);

  @override
  Future<bool> addRechargeSale(RechargeSaleModel rechargeSale) =>
      _database.addRechargeSale(rechargeSale);

  @override
  Future<bool> deleteRecharge(RechargeModel recharge) =>
      _database.deleteRecharge(recharge);

  @override
  Future<bool> deleteRechargeSale(RechargeSaleModel rechargeSale) =>
      _database.deleteRechargeSale(rechargeSale);

  @override
  Stream<List<RechargeSaleModel>> rechargeSaleStream() =>
      _database.rechargeSaleStream();

  @override
  Stream<List<RechargeModel>> rechargeStream() => _database.rechargeStream();

  @override
  Future<bool> updateRecharge(RechargeModel recharge) =>
      _database.updateRecharge(recharge);

  @override
  Future<bool> updateRechargeSale(RechargeSaleModel rechargeSale) =>
      _database.updateRechargeSale(rechargeSale);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


