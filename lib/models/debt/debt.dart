import 'dart:convert';

import 'package:hanouty/components.dart';

import '../../local_components.dart';

import '../payment/payment.dart';
part 'debt_data.dart';
part 'filtered_debts.dart';

class DebtModel {
  String? id;
  String? productName;
  String? clientId;
  String? type; // product or service
  DateTime timeStamp = DateTime.now();
  double amount;
  double paidAmount;
  DateTime deadLine = DateTime.now();

  /// get total amount of debt left to pay
  double get totalAmountLeft => amount - paidAmount;

  /// get is fully paid
  bool get isFullyPaid => totalAmountLeft == 0;
  // get howmany days after deadline
  int get daysOverdue {
    return DateTime.now().difference(deadLine).inDays;
  }

  // get is overdue
  bool get isOverdue {
    return DateTime.now().isAfter(deadLine);
  }

  DebtModel({
    this.id,
    this.productName,
    this.clientId,
    this.type,
    required this.amount,
    required this.paidAmount,
    required this.timeStamp,
    required this.deadLine,
  });

  DebtModel copyWith({
    String? id,
    String? clientName,
    String? clientId,
    String? productName,
    String? type,
    double? amount,
    double? paid,
    int? count,
  }) {
    return DebtModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      clientId: clientId ?? this.clientId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      paidAmount: paid ?? this.paidAmount,
      timeStamp: timeStamp,
      deadLine: deadLine,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'clientId': clientId,
      'type': type,
      'amount': amount,
      'paid': paidAmount,
      'dueDate': deadLine,
      'timeStamp': timeStamp
    };
  }

  factory DebtModel.fromMap(DocumentSnapshot map) {
    Timestamp timeStamp = map['timeStamp'];
    Timestamp dueDatem = map['dueDate'];
    var date = timeStamp.toDate();
    var dueDate = (dueDatem.toDate());

    DebtModel debt = DebtModel(
      id: map.id,
      productName: map['productName'] ?? '',
      clientId: map['clientId'] ?? '',
      type: map['type'] ?? '',
      amount: map['amount'] ?? 0,
      paidAmount: map['paid'] ?? 0,
      timeStamp: date,
      deadLine: dueDate,
    );

    return debt;
  }

  String toJson() => json.encode(toMap());

  factory DebtModel.fromJson(String source) =>
      DebtModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Debt(id: $id, productName: $productName,clientId:$clientId , type: $type, amount: $amount, paid: $paidAmount, dueDate:$deadLine,timeStamp:$timeStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DebtModel &&
        other.id == id &&
        other.productName == productName &&
        other.clientId == clientId &&
        other.type == type &&
        other.amount == amount &&
        other.deadLine == deadLine &&
        other.timeStamp == timeStamp &&
        other.paidAmount == paidAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        clientId.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        paidAmount.hashCode ^
        deadLine.hashCode ^
        timeStamp.hashCode;
  }
}
