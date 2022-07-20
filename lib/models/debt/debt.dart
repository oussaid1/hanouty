import 'dart:convert';

import 'package:hanouty/components.dart';

import '../../local_components.dart';

import '../payment/payment.dart';
part 'debt_data.dart';
part 'filtered_debts.dart';

class DebtModel {
  String? id;
  String? clientName;
  String? productName;
  String? clientId;
  String? type; // product or service
  DateTime timeStamp = DateTime.now();
  double amount;
  double paid;
  DateTime deadLine = DateTime.now();
  int count = 1;
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
    this.clientName,
    this.productName,
    this.clientId,
    this.type,
    required this.amount,
    required this.paid,
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
      clientName: clientName ?? this.clientName,
      productName: productName ?? this.productName,
      clientId: clientId ?? this.clientId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      paid: paid ?? this.paid,
      timeStamp: timeStamp,
      deadLine: deadLine,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientName': clientName,
      'productName': productName,
      'clientId': clientId,
      'type': type,
      'amount': amount,
      'paid': paid,
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
      clientName: map['clientName'] ?? '',
      productName: map['productName'] ?? '',
      clientId: map['clientId'] ?? '',
      type: map['type'] ?? '',
      amount: map['amount'],
      paid: map['paid'],
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
    return 'Debt(id: $id, clientName: $clientName, productName: $productName,clientId:$clientId , type: $type, amount: $amount, paid: $paid, count: $count,dueDate:$deadLine,timeStamp:$timeStamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DebtModel &&
        other.id == id &&
        other.clientName == clientName &&
        other.productName == productName &&
        other.clientId == clientId &&
        other.type == type &&
        other.amount == amount &&
        other.deadLine == deadLine &&
        other.timeStamp == timeStamp &&
        other.paid == paid &&
        other.count == count;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        clientName.hashCode ^
        productName.hashCode ^
        clientId.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        paid.hashCode ^
        count.hashCode;
  }
}
