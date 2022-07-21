import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:hanouty/local_components.dart';

import '../../components.dart';

part 'filtered_product_sales.dart';
part 'filtered_sales.dart';
part 'filtered_service_sales.dart';
part 'sales_data.dart';

enum SaleType { product, service, all }

class SaleTableDataSource extends DataTableSource {
  SaleTableDataSource(
    this.context,
    this.sales,
    this.products, {
    this.onEditPressed,
    this.onDeletePressed,
    this.onUnSellPressed,
  }) : saleRows = sales;
  //final void Function()? onPressed;
  final void Function(SaleModel, ProductModel)? onUnSellPressed;
  void Function(SaleModel)? onDeletePressed;
  void Function(SaleModel)? onEditPressed;
  final BuildContext context;
  List<SaleModel> saleRows = [];
  List<SaleModel> sales = [];
  List<ProductModel> products = [];

  /// get one product by id
  ProductModel? getProductById(String id) {
    try {
      return products.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }
  //final void Function(ProductModel) onProductselcted;

  final int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    // int rowIndex = 0;
    // if (productRows.isNotEmpty) rowIndex = index + 1;
    //log('rowIndex: $rowIndex');
    assert(index >= 0);
    if (index >= saleRows.length) return const DataRow(cells: []);
    final row = saleRows[index];
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
              color: row.saleQualityColor.withOpacity(0.5),
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
            Icons.money_off_outlined,
            color: Color.fromARGB(255, 209, 156, 106),
          ),
          onTap: () {
            onUnSellPressed?.call(row, getProductById(row.productId)!);
          },
        ),
        DataCell(Text(row.productName.toString())),
        DataCell(Text(row.quantitySold.toString())),
        DataCell(Text(row.priceIn.toString())),
        DataCell(Text(row.priceOut.toString())),
        DataCell(Text(getProductById(row.productId)?.suplier ?? '')),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(row.totalPriceSoldFor.toString()),
            Text(
              row.priceSoldFor.toString(),
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        )),
        DataCell(Text(row.dateSold.ddmmyyyy())),
        DataCell(Text(getProductById(row.productId)?.category ?? '')),
        DataCell(Text(row.description.toString())),
        DataCell(
            const Icon(
              Icons.edit_rounded,
            ), onTap: () {
          onEditPressed?.call(row);
        }),
        DataCell(
            const Icon(
              Icons.delete_rounded,
              color: Colors.red,
            ), onTap: () {
          onDeletePressed?.call(row);
        }),
        // DataCell(Text(row.suplier.toString())),
        // DataCell(Text(row.description.toString())),
      ],
    );
  }

  @override
  int get rowCount => saleRows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void sort<T>(Comparable<T> Function(SaleModel d) getField, bool ascending) {
    saleRows.sort((SaleModel a, SaleModel b) {
      if (!ascending) {
        final SaleModel c = a;
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
      saleRows = sales;
      notifyListeners();
    }
    switch (category) {
      case "ID":
        saleRows = sales
            .where((row) => row.id.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Barcode":
        saleRows = sales
            .where((row) => row.barcode.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Name":
        sales
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price In":
        saleRows = sales
            .where((row) => row.priceIn.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Price Out":
        saleRows = sales
            .where(
                (row) => row.priceOut.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Quantity":
        saleRows = sales
            .where((row) =>
                row.quantitySold.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;

      case "Date In":
        saleRows = sales
            .where(
                (row) => row.dateSold.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Suplier":
        saleRows = sales
            .where((row) => row.suplier.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      case "Description":
        saleRows = sales
            .where((row) =>
                row.description.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
      default:
        saleRows = sales
            .where((row) =>
                row.productName.toString().toLowerCase().contains(text))
            .toList();
        notifyListeners();
        break;
    }
  }
}

class SaleModel extends ProductModel {
  String? saleId;
  String productId;
  String shopClientId;
  DateTime dateSold;
  int quantitySold;
  double priceSoldFor;
  SaleType? type;
  String? saleDescription;
  ////////////////////////////////////////////////
  ///Constructors /////////

  SaleModel({
    this.saleId,
    required this.productId,
    required this.shopClientId,
    required this.dateSold,
    required this.quantitySold,
    required this.priceSoldFor,
    required this.type,
    this.saleDescription,
    ProductModel? product,
  }) : super(
          id: product?.id,
          barcode: product?.barcode ?? '',
          productName: product?.productName ?? '',
          description: product?.description ?? '',
          category: product?.category ?? '',
          dateIn: product?.dateIn ?? DateTime.now(),
          quantity: product?.quantity ?? 0,
          priceIn: product?.priceIn ?? 0,
          priceOut: product?.priceOut ?? 0,
          suplier: product?.suplier ?? '',
        );
  ////////////////////////////////////////////////
  double get totalPriceSoldFor {
    return (priceSoldFor * quantitySold);
  }

  bool saleSelected = false;
// get the auality of sale acoording to price sod for in comparison with price in
  int get saleQuality {
    if (totalPriceSoldFor < priceIn) {
      return -1;
    } else if (totalPriceSoldFor > priceIn) {
      return 1;
    }
    return 0;
  }

  // get the color of the sale quality
  Color get saleQualityColor {
    if (saleQuality == -1) {
      return Colors.red;
    } else if (saleQuality == 1) {
      return const Color.fromARGB(255, 42, 114, 78);
    }
    return Colors.orange;
  }

  double get totalPriceIn {
    var total = 0.0;
    total += (priceIn * quantitySold);
    return total;
  }

  double get profitMargin {
    var net = 0.0;
    net += (totalPriceSoldFor - totalPriceIn);
    return net;
  }

  double get totalPriceOut {
    var total = 0.0;
    total += (priceOut * quantitySold);
    return total;
  }

  /// get fields as list of strings
  static const List<String> fieldStrings = [
    'soldItemId',
    'dateSold',
    'quantitySold',
    'itemSoldTitle',
    'shopClientId',
    'priceSoldFor',
    'priceIn',
    'priceOut',
    'type',
    'barcode',
    'description',
    'count',
  ];

  /// Columns for the DataTable.
  static const columns = [
    DataColumn(
      label: Text('ID'),
      tooltip: 'ID',
    ),
    DataColumn(
      label: Text('Unsell'),
      tooltip: 'Unsell',
    ),
    // DataColumn(
    //   label: Text('Barcode'),
    //   tooltip: 'Barcode',
    // ),
    DataColumn(
      label: Text('Product Name'),
      tooltip: 'Product Name',
    ),
    DataColumn(
      label: Text('Quantity'),
      tooltip: 'Quantity',
    ),
    DataColumn(
      label: Text('Price In'),
      tooltip: 'Price In',
    ),
    DataColumn(
      label: Text('Price Out'),
      tooltip: 'Price Out',
    ),
    DataColumn(
      label: Text('Suplier'),
      tooltip: 'Suplier',
    ),
    DataColumn(
      label: Text('Price Sold For'),
      tooltip: 'Price Sold For',
    ),
    DataColumn(
      label: Text('Date In'),
      tooltip: 'Date In',
    ),
    DataColumn(
      label: Text('Category'),
      tooltip: 'Category',
    ),
    DataColumn(
      label: Text('Description'),
      tooltip: 'Description',
    ),
    DataColumn(
      label: Text('Edit'),
      tooltip: 'Edit',
    ),
    DataColumn(
      label: Text('Delete'),
      tooltip: 'Delete',
    ),
  ];

  /// copywith for the model
  SaleModel copySaleWith({
    String? saleId,
    String? productId,
    String? shopClientId,
    int? quantitySold,
    DateTime? dateSold,
    double? priceSoldFor,
    String? saleDescription,
    SaleType? type,
  }) {
    return SaleModel(
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      shopClientId: shopClientId ?? this.shopClientId,
      dateSold: dateSold ?? this.dateSold,
      quantitySold: quantitySold ?? this.quantitySold,
      priceSoldFor: priceSoldFor ?? this.priceSoldFor,
      type: type,
      saleDescription: saleDescription ?? this.saleDescription,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'saleId': saleId,
      'productId': productId,
      'shopClientId': shopClientId,
      'dateSold': dateSold,
      'quantitySold': quantitySold,
      'priceSoldFor': priceSoldFor,
      'type': type,
      'saleDescription': saleDescription,
    };
  }

  factory SaleModel.fromMap(DocumentSnapshot map) {
    final type =
        map['type'].toString().trim() == SaleType.product.toString().trim()
            ? SaleType.product
            : SaleType.service;
    // print(map['type']);
    return SaleModel(
      saleId: map.id,
      productId: map['soldItemId'],
      shopClientId: map['shopClientId'],
      dateSold: map['dateSold'].toDate(),
      quantitySold: map['quantitySold'],
      priceSoldFor: map['priceSoldFor'] ?? 0,
      type: type,
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory SaleModel.fromJson(String source) =>
      SaleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SaleModel(id: $saleId, productId: $productId, shopClientId: $shopClientId , dateSold: $dateSold, quantitySold: $quantitySold, priceSoldFor: $priceSoldFor, type: $type, saleDescription: $saleDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SaleModel &&
        other.saleId == saleId &&
        other.productId == productId &&
        other.shopClientId == shopClientId &&
        other.dateSold == dateSold &&
        other.quantitySold == quantitySold &&
        other.priceSoldFor == priceSoldFor &&
        other.type == type &&
        other.saleDescription == saleDescription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        shopClientId.hashCode ^
        dateSold.hashCode ^
        quantitySold.hashCode ^
        priceSoldFor.hashCode ^
        priceIn.hashCode ^
        priceOut.hashCode ^
        type.hashCode ^
        barcode.hashCode ^
        suplier.hashCode ^
        category.hashCode ^
        description.hashCode;
  }
}

// class SaleModel {
//   String? id;
//   String soldItemId;
//   DateTime dateSold;
//   DateTime? dateIn;
//   int quantitySold;
//   String productSoldName;
//   String? shopClientId;
//   double priceSoldFor;
//   double priceIn;
//   double priceOut;
//   SaleType? type;
//   String? barcode = '';
//   String? suplier = '';
//   String? category = '';
//   String? description;
//   int count = 1;

//   bool selected = false;
//   double get totalPriceSoldFor {
//     return (priceSoldFor * quantitySold);
//   }

// // get the auality of sale acoording to price sod for in comparison with price in
//   int get saleQuality {
//     if (totalPriceSoldFor < priceIn) {
//       return -1;
//     } else if (totalPriceSoldFor > priceIn) {
//       return 1;
//     }
//     return 0;
//   }

//   // get the color of the sale quality
//   Color get saleQualityColor {
//     if (saleQuality == -1) {
//       return Colors.red;
//     } else if (saleQuality == 1) {
//       return const Color.fromARGB(255, 42, 114, 78);
//     }
//     return Colors.orange;
//   }

//   double get totalPriceIn {
//     var total = 0.0;
//     total += (priceIn * quantitySold);
//     return total;
//   }

//   double get profitMargin {
//     var net = 0.0;
//     net += (totalPriceSoldFor - totalPriceIn);
//     return net;
//   }

//   double get totalPriceOut {
//     var total = 0.0;
//     total += (priceOut * quantitySold);
//     return total;
//   }

//   /// get fields as list of strings
//   static const List<String> fieldStrings = [
//     'soldItemId',
//     'dateSold',
//     'quantitySold',
//     'itemSoldTitle',
//     'shopClientId',
//     'priceSoldFor',
//     'priceIn',
//     'priceOut',
//     'type',
//     'barcode',
//     'description',
//     'count',
//   ];

//   /// Columns for the DataTable.
//   static const columns = [
//     DataColumn(
//       label: Text('ID'),
//       tooltip: 'ID',
//     ),
//     DataColumn(
//       label: Text('Unsell'),
//       tooltip: 'Unsell',
//     ),
//     // DataColumn(
//     //   label: Text('Barcode'),
//     //   tooltip: 'Barcode',
//     // ),
//     DataColumn(
//       label: Text('Product Name'),
//       tooltip: 'Product Name',
//     ),
//     DataColumn(
//       label: Text('Quantity'),
//       tooltip: 'Quantity',
//     ),
//     DataColumn(
//       label: Text('Price In'),
//       tooltip: 'Price In',
//     ),
//     DataColumn(
//       label: Text('Price Out'),
//       tooltip: 'Price Out',
//     ),
//     DataColumn(
//       label: Text('Suplier'),
//       tooltip: 'Suplier',
//     ),
//     DataColumn(
//       label: Text('Price Sold For'),
//       tooltip: 'Price Sold For',
//     ),
//     DataColumn(
//       label: Text('Date In'),
//       tooltip: 'Date In',
//     ),
//     DataColumn(
//       label: Text('Category'),
//       tooltip: 'Category',
//     ),
//     DataColumn(
//       label: Text('Description'),
//       tooltip: 'Description',
//     ),
//     DataColumn(
//       label: Text('Edit'),
//       tooltip: 'Edit',
//     ),
//     DataColumn(
//       label: Text('Delete'),
//       tooltip: 'Delete',
//     ),
//   ];

//   SaleModel({
//     this.id,
//     required this.soldItemId,
//     required this.dateSold,
//     this.dateIn,
//     required this.quantitySold,
//     required this.productSoldName,
//     this.shopClientId,
//     required this.priceSoldFor,
//     required this.priceIn,
//     required this.priceOut,
//     required this.type,
//     this.barcode,
//     this.suplier,
//     this.category,
//     this.description,
//   });

//   SaleModel copyWith({
//     String? id,
//     String? soldItemId,
//     DateTime? dateSold,
//     int? quantitySold,
//     String? itemSoldTitle,
//     String? shopClientId,
//     double? priceSoldFor,
//     double? priceIn,
//     double? priceOut,
//     SaleType? type,
//     String? description,
//     String? barcode,
//     String? itemSoldCategory,
//     String? suplier,
//     String? category,
//   }) {
//     return SaleModel(
//       id: id ?? this.id,
//       soldItemId: soldItemId ?? this.soldItemId,
//       dateSold: dateSold ?? this.dateSold,
//       quantitySold: quantitySold ?? this.quantitySold,
//       productSoldName: itemSoldTitle ?? productSoldName,
//       shopClientId: shopClientId ?? this.shopClientId,
//       priceSoldFor: priceSoldFor ?? this.priceSoldFor,
//       priceIn: priceIn ?? this.priceIn,
//       priceOut: priceOut ?? this.priceOut,
//       type: this.type,
//       barcode: barcode ?? this.barcode,
//       suplier: suplier ?? this.suplier,
//       category: category ?? this.category,
//       description: description ?? this.description,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'soldItemId': soldItemId,
//       'dateSold': dateSold,
//       'quantitySold': quantitySold,
//       'itemSoldTitle': productSoldName,
//       'shopClientId': shopClientId,
//       'priceSoldFor': priceSoldFor,
//       'priceIn': priceIn,
//       'priceOut': priceOut,
//       'type': type.toString(),
//       'barcode': barcode,
//       'description': description,
//       'category': category,
//       'suplier': suplier,
//     };
//   }

//   factory SaleModel.fromMap(DocumentSnapshot map) {
//     final type =
//         map['type'].toString().trim() == SaleType.product.toString().trim()
//             ? SaleType.product
//             : SaleType.service;
//     // print(map['type']);
//     return SaleModel(
//       id: map.id,
//       soldItemId: map['soldItemId'],
//       dateIn: map['dateIn'].toDate() ?? DateTime.now(),
//       dateSold: map['dateSold'].toDate(),
//       quantitySold: map['quantitySold'],
//       productSoldName: map['itemSoldTitle'] ?? '',
//       shopClientId: map['shopClientId'] ?? '',
//       priceSoldFor: map['priceSoldFor'] ?? 0,
//       priceOut: map['priceOut'] ?? 0,
//       priceIn: map['priceIn'] ?? 0,
//       type: type,
//       barcode: map['barcode'] ?? '',
//       suplier: map['suplier'] ?? '',
//       category: map['category'] ?? '',
//       description: map['description'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory SaleModel.fromJson(String source) =>
//       SaleModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'SaleModel(id: $id, soldItemId: $soldItemId, dateSold: $dateSold, quantitySold: $quantitySold, productSoldName: $productSoldName, shopClientId: $shopClientId, priceSoldFor: $priceSoldFor, priceIn: $priceIn, priceOut: $priceOut, type: $type, barcode: $barcode, suplier: $suplier, category: $category, description: $description)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is SaleModel &&
//         runtimeType == other.runtimeType &&
//         id == other.id &&
//         soldItemId == other.soldItemId &&
//         dateSold == other.dateSold &&
//         quantitySold == other.quantitySold &&
//         productSoldName == other.productSoldName &&
//         shopClientId == other.shopClientId &&
//         priceSoldFor == other.priceSoldFor &&
//         priceIn == other.priceIn &&
//         priceOut == other.priceOut &&
//         type == other.type &&
//         barcode == other.barcode &&
//         suplier == other.suplier &&
//         category == other.category &&
//         description == other.description;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         soldItemId.hashCode ^
//         dateSold.hashCode ^
//         quantitySold.hashCode ^
//         productSoldName.hashCode ^
//         shopClientId.hashCode ^
//         priceSoldFor.hashCode ^
//         priceIn.hashCode ^
//         priceOut.hashCode ^
//         type.hashCode ^
//         barcode.hashCode ^
//         suplier.hashCode ^
//         category.hashCode ^
//         description.hashCode;
//   }

//   TechServiceModel toTechService({TechServiceModel? techService}) {
//     return techService == null
//         ? TechServiceModel(
//             id: id,
//             type: type!.value,
//             priceIn: priceIn,
//             priceOut: priceOut,
//             description: '',
//             timeStamp: dateSold,
//             title: productSoldName,
//           )
//         : TechServiceModel(
//             id: techService.id,
//             type: techService.type,
//             priceIn: techService.priceIn,
//             priceOut: techService.priceOut,
//             description: techService.description,
//             timeStamp: techService.timeStamp,
//             title: techService.title,
//           );
//   }

//   ProductModel toProduct({ProductModel? product}) {
//     return product == null
//         ? ProductModel(
//             id: id,
//             category: type!.value,
//             barcode: barcode,
//             dateIn: dateSold,
//             description: '',
//             productName: productSoldName,
//             suplier: '',
//             priceIn: priceIn,
//             priceOut: priceOut,
//             quantity: quantitySold,
//           )
//         : ProductModel(
//             id: product.id,
//             category: product.category,
//             barcode: product.barcode,
//             dateIn: product.dateIn,
//             description: product.description,
//             productName: product.productName,
//             suplier: product.suplier,
//             priceIn: product.priceIn,
//             priceOut: product.priceOut,
//             quantity: product.quantity,
//           );
//   }

//   ProductModel toProductToUnsell(
//       {required SaleModel sale, required ProductModel product}) {
//     return ProductModel(
//       id: product.id,
//       category: product.category,
//       barcode: product.barcode,
//       dateIn: product.dateIn,
//       description: product.description,
//       productName: product.productName,
//       suplier: product.suplier,
//       priceIn: product.priceIn,
//       priceOut: product.priceOut,
//       quantity: product.quantity + sale.quantitySold,
//     );
//   }
// }
