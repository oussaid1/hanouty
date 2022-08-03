import 'package:hanouty/local_components.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/models/product/product_calculations.dart';

class TaggedProducts {
  String tag;
  Color? mColor;
  List<ProductModel> products;
  DateTime? mDate;

  get count {
    return products.length;
  }

  TaggedProducts({
    required this.tag,
    required this.products,
  });

  ProductCalculations get productsData {
    return ProductCalculations(products: products);
  }
}
