import 'dart:convert';
import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';

part 'techservices_data.dart';

class TechServiceModel {
  String? id;
  String title;
  String type;
  String? description = 'legal only';
  double priceIn = 0;
  double priceOut = 0;

  DateTime timeStamp = DateTime.now();
  int count = 1;

  bool? available = true;

  TechServiceModel({
    this.id,
    required this.title,
    required this.type,
    this.description,
    required this.priceIn,
    required this.priceOut,
    this.available,
    required this.timeStamp,
  });
  TechServiceModel copyWith({
    String? id,
    String? title,
    String? type,
    String? description,
    double? priceIn,
    double? priceOut,
    double? soldFor,
    int? quantitySold,
    int? count,
    bool? available,
  }) {
    return TechServiceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      priceIn: priceIn ?? this.priceIn,
      priceOut: priceOut ?? this.priceOut,
      available: available ?? this.available,
      timeStamp: timeStamp,
    );
  }

  /// fromSale
  /// converts a SaleModel to a TechService
  static TechServiceModel fromSale(SaleModel sale) {
    return TechServiceModel(
      id: sale.id,
      title: sale.productSoldName,
      type: sale.type.toString(),
      description: sale.description,
      priceIn: sale.priceIn,
      priceOut: sale.priceOut,
      available: true,
      timeStamp: sale.dateSold,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'priceIn': priceIn,
      'priceOut': priceOut,
      'available': available,
      'timeStamp': timeStamp,
    };
  }

  factory TechServiceModel.fromMap(DocumentSnapshot map) {
    return TechServiceModel(
        id: map.id,
        title: map['title'],
        type: map['type'],
        description: map['description'],
        priceIn: map['priceIn'],
        priceOut: map['priceOut'],
        available: map['available'],
        timeStamp: map['timeStamp'].toDate());
  }

  String toJson() => json.encode(toMap());

  String get formattedDate {
    return (timeStamp).ddmmyyyy();
  }

  factory TechServiceModel.fromJson(String source) =>
      TechServiceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Services(id: $id, title: $title, type: $type,priceIn: $priceIn, priceOut: $priceOut, count: $count, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TechServiceModel &&
        other.id == id &&
        other.title == title &&
        other.type == type &&
        other.priceIn == priceIn &&
        other.priceOut == priceOut &&
        other.count == count &&
        other.available == available;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        type.hashCode ^
        priceIn.hashCode ^
        priceOut.hashCode ^
        count.hashCode ^
        available.hashCode;
  }
}
