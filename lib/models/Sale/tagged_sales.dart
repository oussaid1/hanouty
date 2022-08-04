import 'dart:math';

import 'package:hanouty/local_components.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/models/Sale/sales_calculations.dart';

class TaggedSales {
  String tag;
  Color? mColor;
  List<SaleModel> sales;
  DateTime? mDate;

  get count {
    return sales.length;
  }

  TaggedSales(
      {required this.tag, required this.sales, this.mDate, this.mColor});

  SaleCalculations get salesData {
    return SaleCalculations(sales: sales);
  }

  FilteredSales? get filteredSalesData {
    return FilteredSales(sales: sales);
  }

  /// get a random color as rgb for the tag
  Color get randomColor {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }
}
