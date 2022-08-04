import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../models/recharge/recharge.dart';

extension Neumorphism on Widget {
  addNeumorphism({
    double borderRadius = 10.0,
    Offset offset = const Offset(5, 5),
    double blurRadius = 10,
    Color topShadowColor = Colors.white60,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}

/// this extension is used to provide MediaQuery.of(context).size.width and height and navigation
extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  void gotoPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

extension DtExtension on DateTime {
  String formatted() {
    try {
      return DateFormat("yyyy-MM-dd").format(this);
    } catch (e) {
      return '';
    }
  }

  String formattedHH() {
    try {
      return DateFormat.yMd().add_jm().format(this);
    } catch (e) {
      return '';
    }
  }
}

extension EnumParser2 on String {
  DateTime? get getDate {
    List<String> date = split('-');
    if (date.length == 3) {
      return DateTime.parse(this);
    } else if (date.length == 2) {
      return DateTime.parse('${date[0]}-${date[1]}-01');
    } else if (date.length == 1) {
      return DateTime.parse('${date[0]}-01-01');
    }
    return null;
  }
}

/// extension on [List<String>] to turn all items to lower case
extension LowerCaseList on List<String> {
  List<String> toLowerCase() {
    for (int i = 0; i < length; i++) {
      this[i] = this[i].toLowerCase();
    }
    return this;
  }
}

/// extension on DateTime to get a string in the format dd/mm/yyyy
extension DateTimeExt on DateTime {
  String ddmmyyyy() {
    return '$day/$month/$year';
  }
}

/// extention on context to get the current theme
extension ThemeExt on BuildContext {
  ColorScheme get theme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension Ex on double {
  double toPrecision(int digitsAfter) =>
      double.parse(toStringAsFixed(digitsAfter));
}

extension EnumExtension on String {
  RechargeOperator toRechargeOperator() {
    switch (this) {
      case 'RechargeOperator.orange':
        return RechargeOperator.orange;
      case 'RechargeOperator.inwi':
        return RechargeOperator.inwi;
      case 'RechargeOperator.iam':
        return RechargeOperator.iam;
      default:
        return RechargeOperator.inwi;
    }
  }
}

extension SaleListExtension on List<SaleModel> {
  List<SaleModel> buildSalesList(List<ProductModel> productModels) {
    List<SaleModel> sales = [];
    for (SaleModel sale in this) {
      for (ProductModel product in productModels) {
        if (sale.productId == product.pId) {
          log('product found');
          sales.add(SaleModel(
              saleId: sale.saleId,
              productId: sale.productId,
              shopClientId: sale.shopClientId,
              dateSold: sale.dateSold,
              quantitySold: sale.quantitySold,
              priceSoldFor: sale.priceSoldFor,
              saleDescription: sale.saleDescription,
              type: sale.type,
              product: product));
        }
      }
    }
    return sales;
  }
}

extension RechargeSaleListWithRechargeModel on List<RechargeSaleModel> {
  List<RechargeSaleModel> combineWithRechargeModel(
      List<RechargeModel> rechargeModelList) {
    List<RechargeSaleModel> combinedList = [];
    for (RechargeSaleModel rechargeSale in this) {
      for (RechargeModel recharge in rechargeModelList) {
        if (rechargeSale.soldRchrgId == recharge.id) {
          combinedList.add(rechargeSale.copyRSWith(
            rechargeModel: recharge,
          ));
        }
      }
    }
    return combinedList;
  }
}

extension RechargeSaleListWithShopClient on List<RechargeSaleModel> {
  List<RechargeSaleModel> combineWithShopclients(
      List<ShopClientModel> shopClients) {
    List<RechargeSaleModel> combinedList = [];
    for (RechargeSaleModel rechargeSale in this) {
      for (ShopClientModel shopClient in shopClients) {
        if (rechargeSale.clntID == shopClient.id) {
          combinedList.add(rechargeSale.copyRSWith(
            shopClientModel: shopClient,
          ));
        }
      }
    }
    return combinedList;
  }
}

extension ProductListExtension on List<ProductModel> {
  List<ProductModel> buildFullProdcutList(List<SuplierModel> supliers) {
    List<ProductModel> combinedList = [];
    for (ProductModel product in this) {
      for (SuplierModel suplier in supliers) {
        if (product.suplierId == suplier.id) {
          combinedList.add(product.copyWith(
            suplierModel: suplier,
          ));
        }
      }
    }
    return combinedList;
  }
}

extension Group<T> on Iterable<T> {
  Map<K, Iterable<T>> groupBy<K>(K Function(T) key) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final keyValue = key(element);
      !map.containsKey(keyValue)
          ? map[keyValue] = [element]
          : map[keyValue]!.add(element);
    }
    return map;
  }
}
