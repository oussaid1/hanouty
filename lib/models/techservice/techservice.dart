import 'dart:convert';
import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';

part 'techservices_data.dart';

class TechServiceModel extends ProductModel {
  String? pId;
  String title;
  SaleType type;
  String? serviceDescription = 'legal only';
  DateTime createdAt = DateTime.now();
  bool? available = true;

  TechServiceModel({
    this.pId,
    required this.title,
    required this.type,
    required this.serviceDescription,
    required this.createdAt,
    this.available,
    ProductModel? product,
  }) : super(
          pId: product?.pId,
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

  TechServiceModel copyServiceWith({
    String? id,
    String? title,
    SaleType? type,
    String? serviceDescription,
    DateTime? createdAt,
    bool? available,

    // ProductModel? product,
  }) {
    return TechServiceModel(
      pId: id ?? this.pId,
      title: title ?? this.title,
      type: type ?? this.type,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      createdAt: createdAt ?? this.createdAt,
      available: available ?? this.available,
      //product: product ?? this.product,
    );
  }

  /// fromSale
  /// converts a SaleModel to a TechService
  // static TechServiceModel fromSale(SaleModel sale) {
  //   return TechServiceModel(
  //     id: sale.id,
  //     title: sale.productName,
  //     type: sale.type!,
  //     serviceDescription: sale.serviceDescription,
  //     createdAt: sale.createdAt,
  //     available: sale.available,
  //     //product: product ?? this.product,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'priceIn': priceIn,
      'priceOut': priceOut,
      'available': available,
      'timeStamp': createdAt,
    };
  }

  factory TechServiceModel.fromMap(DocumentSnapshot map) {
    return TechServiceModel(
        pId: map.id,
        title: map['title'],
        type: map['type'],
        serviceDescription: map['description'],
        available: map['available'],
        createdAt: map['timeStamp'].toDate());
  }

  factory TechServiceModel.fromJson(String source) =>
      TechServiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Services(id: $pId, title: $title, type: $type,priceIn: $priceIn, priceOut: $priceOut, count: $count, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TechServiceModel &&
        other.pId == pId &&
        other.title == title &&
        other.type == type &&
        other.priceIn == priceIn &&
        other.priceOut == priceOut &&
        other.count == count &&
        other.available == available;
  }

  @override
  int get hashCode {
    return pId.hashCode ^
        title.hashCode ^
        type.hashCode ^
        priceIn.hashCode ^
        priceOut.hashCode ^
        count.hashCode ^
        available.hashCode;
  }
}
