import 'dart:convert';

import 'package:hanouty/local_components.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import 'tagged_products.dart';

part 'product_stock.dart';
part 'filtered_products.dart';

enum Availability {
  inStock,
  scarce,
  outofStock,
}

class ProductTableDataSource extends DataTableSource {
  ProductTableDataSource(
    this.context,
    this.products, {
    this.onEditPressed,
    this.onDeletePressed,
    this.onSellPressed,
  }) : productRows = products;
  //final void Function()? onPressed;
  final void Function(ProductModel)? onSellPressed;
  void Function(ProductModel)? onDeletePressed;
  void Function(ProductModel)? onEditPressed;
  final BuildContext context;
  List<ProductModel> productRows = [];
  List<ProductModel> products = [];
  //final void Function(ProductModel) onProductselcted;

  final int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    // int rowIndex = 0;
    // if (productRows.isNotEmpty) rowIndex = index + 1;
    //log('rowIndex: $rowIndex');
    assert(index >= 0);
    if (index >= productRows.length) return const DataRow(cells: []);
    final row = productRows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      // onSelectChanged: (value) {
      //   if (row.selected != value) {
      //     _selectedCount += value! ? 1 : -1;
      //     assert(_selectedCount >= 0);
      //     row.selected = value;
      //     //onProductselcted(row);
      //     notifyListeners();
      //   }
      // },
      cells: [
        // DataCell(Text(rowIndex.toString())),
        DataCell(
          Container(
            margin: const EdgeInsets.only(right: 2.0),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: row.color.withOpacity(0.5),
              //backgroundColor: AppConstants.whiteOpacity,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                row.productName.substring(0, 1),
                style: Theme.of(context).textTheme.subtitle1!,
              ),
            ),
          ),
        ),
        // DataCell(Text('$rowIndex')),
        //DataCell(Text(row.barcode.toString())),
        DataCell(
          const Icon(
            Icons.price_check_rounded,
            color: Color.fromARGB(255, 209, 156, 106),
          ),
          onTap: () {
            onSellPressed?.call(row);
          },
        ),
        DataCell(Text(
          row.productName.toString(),
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(row.quantity.toString())),
        DataCell(Text(row.priceIn.toString())),
        DataCell(Text(row.priceOut.toString())),
        DataCell(Text(row.suplierId.toString())),
        DataCell(Text(row.dateIn.ddmmyyyy())),
        DataCell(Text(row.category.toString())),
        DataCell(Text(
          row.description.toString(),
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(
            const Icon(
              Icons.edit_rounded,
            ), onTap: () {
          onEditPressed?.call(row);
        }),
        // DataCell(
        //     const Icon(
        //       Icons.delete_rounded,
        //       color: Colors.red,
        //     ), onTap: () {
        //   onDeletePressed?.call(row);
        // }),
      ],
    );
  }

  @override
  int get rowCount => productRows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void sort<T>(
      Comparable<T> Function(ProductModel d) getField, bool ascending) {
    productRows.sort((ProductModel a, ProductModel b) {
      if (!ascending) {
        final ProductModel c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  /// filtered by category
  void filterByCategory(String category, String text) {
    text = text.toLowerCase();
    if (text.isEmpty) {
      productRows = products;
      notifyListeners();
    }
    switch (category) {
      case "ID":
        productRows = products
            .where((row) => row.pId.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Barcode":
        productRows = products
            .where((row) => row.barcode.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Name":
        productRows = products
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price In":
        productRows = products
            .where((row) => row.priceIn.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price Out":
        productRows = products
            .where(
                (row) => row.priceOut.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Quantity":
        productRows = products
            .where(
                (row) => row.quantity.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Category":
        productRows = products
            .where(
                (row) => row.category.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Date In":
        productRows = products
            .where((row) => row.dateIn.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Suplier":
        productRows = products
            .where(
                (row) => row.suplierId.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Description":
        productRows = products
            .where((row) =>
                row.description.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      default:
        productRows = products
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
    }
  }
}

class ProductModel {
  String? pId;
  String? barcode;
  String productName;
  String? description;
  String? category;
  DateTime dateIn;
  int quantity;
  double priceIn;
  double priceOut;
  String? suplierId;
////////////////////////////
  SuplierModel? suplierModel;

  ////////////////////////////////////////////////////////////////////////////////
  /// Constructor ///////////////////////////////////////////////////////////////

  ProductModel({
    this.pId,
    this.barcode,
    required this.productName,
    this.description,
    this.category,
    required this.dateIn,
    required this.quantity,
    required this.priceIn,
    required this.priceOut,
    this.suplierId,
    this.suplierModel,
  });

  /// //////////////////////////////////////////////////////////////////////////
  bool hasSales = true;

  /// //////////////////////////////////////////////////////////////////////////
  get availability {
    switch (quantity) {
      case 1:
        return Availability.scarce;
      case 0:
        return Availability.outofStock;

      default:
        return Availability.inStock;
    }
  }

  bool selected = false;

  Color get color {
    switch (quantity) {
      case 0:
        return Colors.red.shade400;
      case 1:
        return Colors.amber.shade800;
      case 2:
        return Colors.amber.shade600;
      case 3:
        return Colors.amber.shade500;
      default:
        Colors.green[300];
    }
    return MThemeData.primaryColor;
  }

  double? get priceOutTotal {
    return (priceOut * quantity);
  }

  double? get priceInTotal {
    return (priceIn * quantity);
  }

  /// check if the product is valid
  bool get isValid {
    if (pId!.isNotEmpty &&
        barcode == barcode &&
        productName.isNotEmpty &&
        quantity.isFinite &&
        priceIn == priceIn &&
        priceOut == priceOut &&
        suplierId == suplierId) {}
    return false;
  }

  /// get fields as list of strings
  static const List<String> fieldStrings = [
    "Barcode",
    "Name",
    "Description",
    "Category",
    "Date",
    "Quantity",
    "Price In",
    "Price Out",
    "Suplier",
  ];

  ProductModel copyWith({
    String? pId,
    String? barcode,
    String? name,
    String? description,
    String? category,
    DateTime? dateIn,
    DateTime? dateOut,
    int? quantity,
    double? priceIn,
    double? priceOut,
    String? suplierId,
    String? availability,
    SuplierModel? suplierModel,
  }) {
    return ProductModel(
      pId: pId ?? this.pId,
      barcode: barcode ?? this.barcode,
      productName: name ?? productName,
      description: description ?? this.description,
      category: category ?? this.category,
      dateIn: dateIn ?? this.dateIn,
      quantity: quantity ?? this.quantity,
      priceIn: priceIn ?? this.priceIn,
      priceOut: priceOut ?? this.priceOut,
      suplierId: suplierId ?? this.suplierId,
      suplierModel: suplierModel ?? this.suplierModel,
    );
  }

  /// Columns for the DataTable.

  Map<String, dynamic> toMap() {
    return {
      if (pId != null) 'id': pId,
      'barcode': barcode ?? '',
      'name': productName,
      'description': description,
      'category': category,
      'dateIn': dateIn,
      'quantity': quantity,
      'priceIn': priceIn,
      'priceOut': priceOut,
      'suplier': suplierId,
    };
  }

  factory ProductModel.fromMap(DocumentSnapshot map) {
    // Timestamp f = map['dateIn'];
    return ProductModel(
      pId: map.id,
      barcode: map['barcode'],
      productName: map['name'],
      description: map['description'],
      category: map['category'],
      dateIn: ((map['dateIn'])).toDate(), //f.toDate(), //
      quantity: (map['quantity']),
      priceIn: (map['priceIn']),
      priceOut: (map['priceOut']),
      suplierId: map['suplier'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $pId, barcode: $barcode, name: $productName, description: $description,category: $category, dateIn: $dateIn, quantity: $quantity, priceIn: $priceIn, priceOut: $priceOut, suplier: $suplierId, availability: $availability)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.pId == pId &&
        other.barcode == barcode &&
        other.productName == productName &&
        other.description == description &&
        other.category == category &&
        other.dateIn == dateIn &&
        other.quantity == quantity &&
        other.priceIn == priceIn &&
        other.priceOut == priceOut &&
        other.suplierId == suplierId;
  }

  @override
  int get hashCode {
    return pId.hashCode ^
        barcode.hashCode ^
        productName.hashCode ^
        description.hashCode ^
        category.hashCode ^
        dateIn.hashCode ^
        quantity.hashCode ^
        priceIn.hashCode ^
        priceOut.hashCode ^
        suplierId.hashCode ^
        availability.hashCode;
  }
}
