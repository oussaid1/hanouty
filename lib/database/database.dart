import 'dart:developer';

import 'package:hanouty/models/Sale/sale.dart';
import 'package:hanouty/models/client/shop_client.dart';
import 'package:hanouty/models/debt/debt.dart';
import 'package:hanouty/models/income/income.dart';
import 'package:hanouty/models/payment/payment.dart';
import 'package:hanouty/models/product/product.dart';
import 'package:hanouty/models/suplier/suplier.dart';
import 'package:hanouty/models/techservice/techservice.dart';
import 'package:hanouty/models/user/user_model.dart';
import 'package:hanouty/components.dart';

import '../models/expenses/expenses.dart';
import '../models/recharge/recharge.dart';

class DbTables {
  static const String products = ('Products');
  static const String recharges = ('Recharges');
  static const String rechargeSales = ('RechargeSales');
  static const String sales = ('Sales');
  static const String techServices = ('TechServices');
  static const String debts = ('Credits');
  static const String payments = ('Payments');
  static const String incomes = ('Incomes');
  static const String expenses = ('Expenses');
  static const String uzers = ('users');
  static const String clients = ('clients');
  static const String supliers = ('Supliers');
}

class Database {
  // static const _getOptions = GetOptions(source:Source.cache,source:Source.server, serverAndCache);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  String? uid;
  Database(this.uid);

  /// set uid of current user
  void setUserUid(String uid) => this.uid = uid;

  Future<bool> createUser(UserModel user) async {
    bool done = false;
    await _firestore
        .collection(DbTables.uzers)
        .doc(user.id)
        .set(user.toMap(), SetOptions(merge: true))
        .then((value) => done = true)
        .catchError((error) {
      done = false;
    });
    return done;
  }

  Future<UserModel?> getUser() async {
    log('getUser');
    log('uid :=> $uid');
    if (uid == null) return null;
    try {
      return await users.doc(uid).get().then(
          (value) => UserModel.fromDocumentSnapshot(documentSnapshot: value));
      // ignore: return_of_invalid_type_from_catch_error
    } catch (error, stackTrace) {
      log('getUser error: $error');
      log('getUser stackTrace: $stackTrace');
      rethrow;
    }
  }

  /// update user
  Future<bool> updateUser(UserModel user) async {
    bool done = false;
    await _firestore
        .collection(DbTables.uzers)
        .doc(user.id)
        .update(user.toMap())
        .then((value) => done = true)
        .catchError((error) {
      done = false;
    });
    return done;
  }

  // add to FireStore
  Future<bool> addClient(ShopClientModel client) {
    return _firestore
        .collection(DbTables.uzers)
        .doc(uid)
        .collection(DbTables.clients)
        .add(client.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addProduct(ProductModel product) {
    return users
        .doc(uid)
        .collection(DbTables.products)
        .add(product.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addSale(SaleModel sale) {
    return users
        .doc(uid)
        .collection(DbTables.sales)
        .add(sale.toMap())
        .then((value) => true)
        .catchError((error) {
      log('addSale error: $error');
      return false;
    });
  }

  Future<bool> addDebt(DebtModel debt) {
    return users
        .doc(uid)
        .collection(DbTables.debts)
        .add(debt.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  // add DbTables.payments to FireStore
  Future<bool> addPayment(PaymentModel payment) {
    return users
        .doc(uid)
        .collection(DbTables.payments)
        .add(payment.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addTechService(TechServiceModel techService) {
    return users
        .doc(uid)
        .collection(DbTables.techServices)
        .add(techService.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addSuplier(SuplierModel suplier) {
    return users
        .doc(uid)
        .collection(DbTables.supliers)
        .add(suplier.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addIncome(IncomeModel income) {
    return users
        .doc(uid)
        .collection(DbTables.incomes)
        .add(income.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addExpense(ExpenseModel expense) {
    return users
        .doc(uid)
        .collection(DbTables.expenses)
        .add(expense.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addRecharge(RechargeModel recharge) {
    return users
        .doc(uid)
        .collection(DbTables.recharges)
        .add(recharge.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> addRechargeSale(RechargeSaleModel rechargeSale) {
    return users
        .doc(uid)
        .collection(DbTables.rechargeSales)
        .add(rechargeSale.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
// get from Firestore
////////////////////////
////////////////////////////
//////////////////////////////////

//get a single product by id as a future of bool
  Future<ProductModel> getProductById(String id) async {
    return await users
        .doc(uid)
        .collection(DbTables.products)
        .doc(id)
        .get()
        .then((value) => ProductModel.fromMap(value))
        .catchError((error) => throw Exception("error"));
  }

  /// get all DbTables.clients from firestore
  Stream<List<ShopClientModel>> clientsStream() {
    return users
        .doc(uid)
        .collection(DbTables.clients)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ShopClientModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(ShopClientModel.fromMap(element));
      }
      return retVal;
    });
  }

  Stream<List<SuplierModel>> supliersStream() {
    return users.doc(uid).collection(DbTables.supliers).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => SuplierModel.fromMap(element))
            .toList(growable: true));
  }

  Stream<List<ProductModel>> productsStream() {
    //  log('productsStream uid: $uid');
    return users.doc(uid!).collection(DbTables.products).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => ProductModel.fromMap(element))
            .toList(growable: true));
  }

  Future<ProductModel> getOneproduct(String id) {
    return users
        .doc(uid)
        .collection(DbTables.products)
        .doc(id)
        .get()
        .then((value) => ProductModel.fromMap(value));
  }

  Stream<List<TechServiceModel>> techServiceStream() {
    return users.doc(uid).collection(DbTables.techServices).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => TechServiceModel.fromMap(element))
            .toList(growable: true));
  }

  Stream<List<SaleModel>> salesStream() {
    return users.doc(uid).collection(DbTables.sales).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => SaleModel.fromMap(element))
            .toList(growable: true));
  }

  Stream<List<DebtModel>> debtStream() {
    return users.doc(uid).collection(DbTables.debts).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => DebtModel.fromMap(element))
            .toList(growable: true));
  }

// get a stream of List of DbTables.payments
  Stream<List<PaymentModel>> paymentStream() {
    return users.doc(uid).collection(DbTables.payments).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => PaymentModel.fromMap(element))
            .toList(growable: true));
  }

  Stream<List<IncomeModel>> incomeStream() {
    return users.doc(uid).collection(DbTables.incomes).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => IncomeModel.fromMap(element))
            .toList(growable: true));
  }

  Stream<List<ExpenseModel>> expenseStream() {
    return users.doc(uid).collection(DbTables.expenses).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => ExpenseModel.fromMap(element))
            .toList(growable: true));
  }

  Stream<List<RechargeModel>> rechargeStream() {
    return users.doc(uid).collection(DbTables.recharges).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => RechargeModel.fromDocumentSnapshot(element))
            .toList(growable: true));
  }

  Stream<List<RechargeSaleModel>> rechargeSaleStream() {
    return users.doc(uid).collection(DbTables.rechargeSales).snapshots().map(
        (QuerySnapshot query) => query.docs
            .map((element) => RechargeSaleModel.fromDocument(element))
            .toList(growable: true));
  }

  // update in firestore
  //////////////////////
  ////////////////////////////
  ////////////////////////////////
  Future<bool> updateProduct(ProductModel product) {
    return users
        .doc(uid!)
        .collection(DbTables.products)
        .doc(product.pId)
        .set(product.toMap(), SetOptions(merge: true))
        .then((value) => true)
        .catchError((error) => false);
  }

  /// update Product Quantity in firestore
  Future<bool> updateProductQuantity(
      {required String productId, required int quantity}) {
    return users
        .doc(uid!)
        .collection(DbTables.products)
        .doc(productId.trim())
        .set({'quantity': quantity}, SetOptions(merge: true))
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateRechargeQuantity(
      {required String rechargeId, required num qntty}) {
    return users
        .doc(uid!)
        .collection(DbTables.recharges)
        .doc(rechargeId.trim())
        .set({'qnt': qntty}, SetOptions(merge: true))
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateSale(
    SaleModel sale,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.sales)
        .doc(sale.saleId)
        .update(sale.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateTechService(
    TechServiceModel techService,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.techServices)
        .doc(techService.pId)
        .update(techService.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateDebt(
    DebtModel debt,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.debts)
        .doc(debt.id)
        .update(debt.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

// update Payment in firestore
  Future<bool> updatePayment(
    PaymentModel payment,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.payments)
        .doc(payment.id)
        .update(payment.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateClient(
    ShopClientModel client,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.clients)
        .doc(client.id)
        .update(client.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateSuplier(
    SuplierModel suplier,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.supliers)
        .doc(suplier.id)
        .update(suplier.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateIncome(
    IncomeModel income,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.incomes)
        .doc(income.id)
        .update(income.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateExpense(
    ExpenseModel expense,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.expenses)
        .doc(expense.id)
        .update(expense.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateRecharge(
    RechargeModel recharge,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.recharges)
        .doc(recharge.id)
        .update(recharge.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateRechargeSale(
    RechargeSaleModel rechargeSale,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.rechargeSales)
        .doc(rechargeSale.rSId)
        .update(rechargeSale.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  // delete in firestore
  /////////////////////
  /////////////////////
  Future<bool> deleteProduct(
    ProductModel product,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.products)
        .doc(product.pId)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteTechService(
    TechServiceModel techService,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.techServices)
        .doc(techService.pId)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteSuplier(
    SuplierModel suplier,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.supliers)
        .doc(suplier.id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteDebt(
    DebtModel debt,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.debts)
        .doc(debt.id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

// delete Payment in firestore
  Future<bool> deletePayment(
    PaymentModel payment,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.payments)
        .doc(payment.id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteClient(
    ShopClientModel client,
  ) {
    return users
        .doc(uid)
        .collection(DbTables.clients)
        .doc(client.id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteSale(SaleModel sale) {
    return users
        .doc(uid)
        .collection(DbTables.sales)
        .doc(sale.saleId)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteIncome(IncomeModel income) {
    return users
        .doc(uid)
        .collection(DbTables.incomes)
        .doc(income.id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteExpense(ExpenseModel expense) {
    return users
        .doc(uid)
        .collection(DbTables.expenses)
        .doc(expense.id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteRecharge(RechargeModel recharge) {
    return users
        .doc(uid)
        .collection(DbTables.recharges)
        .doc(recharge.id)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> deleteRechargeSale(RechargeSaleModel rechargeSale) {
    return users
        .doc(uid)
        .collection(DbTables.rechargeSales)
        .doc(rechargeSale.rSId)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }
}
