import 'dart:developer';

import 'package:hanouty/models/Sale/sale.dart';
import 'package:hanouty/models/expenses/expenses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components.dart';
import '../models/product/product.dart';

// Our design contains Neumorphism design and i made a extention for it
// We can apply it on any  widget
/// TODO: Test this extension
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

  String ddmmyyyy() {
    try {
      return DateFormat("yyyy-MM-dd").format(this);
    } catch (e) {
      return '';
    }
  }

  String mmyyyy() {
    try {
      return DateFormat("yyyy-MM").format(this);
    } catch (e) {
      return '';
    }
  }

  String yyyy() {
    try {
      return DateFormat("yyyy").format(this);
    } catch (e) {
      return '';
    }
  }

  DateTime stripTime() {
    {
      return DateTime(year, month, day, 0, 0, 0);
    }
  }

  DateTime stripTimeDay() {
    {
      return DateTime(year, month, 00);
    }
  }

  DateTime stripTimeDayMonth() {
    {
      return DateTime(year, 00, 00);
    }
  }
}

extension Ex on double {
  double toPrecision(int digitsAfter) =>
      double.parse(toStringAsFixed(digitsAfter));
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

extension SaleListExtension on List<SaleModel> {
  List<SaleModel> buildSalesList(List<ProductModel> productModels) {
    List<SaleModel> sales = [];
    for (SaleModel sale in this) {
      for (ProductModel product in productModels) {
        if (sale.productId == product.id) {
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
