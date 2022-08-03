// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';

enum RechargeOperator {
  orange,
  inwi,
  iam,
}

class RechargeModel {
  String? id;
  RechargeOperator oprtr;
  double percntg;
  double amount;
  num qntt;
  DateTime date;

  RechargeModel({
    this.id,
    required this.oprtr,
    required this.percntg,
    required this.amount,
    required this.qntt,
    required this.date,
  });

  RechargeModel copyWith({
    String? id,
    RechargeOperator? oprtr,
    double? percntg,
    double? amount,
    num? qntt,
    DateTime? date,
    String? suplyrID,
  }) {
    return RechargeModel(
      id: id ?? this.id,
      oprtr: oprtr ?? this.oprtr,
      percntg: percntg ?? this.percntg,
      amount: amount ?? this.amount,
      qntt: qntt ?? this.qntt,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //if (id != null) 'id': id,
      'oprtr': oprtr.toString(),
      'percntg': percntg,
      'amount': amount,
      'qnt': qntt,
      'date': date,
    };
  }

  factory RechargeModel.fromMap(Map<String, dynamic> map) {
    var ob = RechargeModel(
      id: map['id'],
      oprtr: map['oprtr'].toString().toRechargeOperator(),
      percntg: map['percntg'] ?? 0.0,
      amount: map['amount'] ?? 0.0,
      qntt: map['qnt'] ?? 0,
      date: map['date'].toDate(),
    );
    return ob;
  }

  /// from documentsnapshot
  factory RechargeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var r = RechargeModel(
      id: doc.id,
      oprtr: doc['oprtr'].toString().toRechargeOperator(),
      percntg: doc['percntg'] ?? 0,
      amount: doc['amount'] ?? 0,
      qntt: doc['qnt'] ?? 0,
      date: doc['date'].toDate(),
    );
    return r;
  }
  String toJson() => json.encode(toMap());

  factory RechargeModel.fromJson(String source) =>
      RechargeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RachargeModel(id: $id, oprtr: $oprtr, percntg: $percntg, amount: $amount, qnt: $qntt, date: $date,)';
  }

//////////////////////////////////////////////////// get the recharge amount for a given amount
  num get netProfit {
    return (amount * percntg) / 100;
  }

  /// get total amount of the sale of the recharge
  /// @return num [amount * quantitySold]total amount of the sale of the recharge
  num get totalAmount {
    return amount * qntt;
  }

  /// get color acording to the operator
  Color get color {
    switch (oprtr) {
      case RechargeOperator.orange:
        return orange;
      case RechargeOperator.inwi:
        return inwi;
      case RechargeOperator.iam:
        return iam;
    }
  }

  static Color getOprtrColor(RechargeOperator oprtr) {
    switch (oprtr) {
      case RechargeOperator.orange:
        return orange;
      case RechargeOperator.inwi:
        return inwi;
      case RechargeOperator.iam:
        return iam;
    }
  }

  static const Color orange = Colors.orange;
  static const Color inwi = Colors.purple;
  static const Color iam = Colors.blue;
}

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
class RechargeSaleModel extends RechargeModel {
  String? rSId;
  num qnttSld;
  DateTime dateSld;
  String? clntID;
  String? soldRchrgId;
//////////////////////////////////////////////////////////////////////////////////////////////
  RechargeModel? rechargeModel;
  ShopClientModel? shopClientModel;
  //////////////////////////////////////////////////////////////////////////////////////////////
  /////// constructor for the recharge sale model //////////////////////////////////////////////

  RechargeSaleModel({
    this.clntID,
    this.rSId,
    required this.qnttSld,
    required this.soldRchrgId,
    required this.dateSld,
    this.rechargeModel,
    this.shopClientModel,
  }) : super(
          id: rechargeModel?.id,
          oprtr: rechargeModel?.oprtr ?? RechargeOperator.orange,
          percntg: rechargeModel?.percntg ?? 0.0,
          amount: rechargeModel?.amount ?? 0.0,
          qntt: rechargeModel?.qntt ?? 0,
          date: rechargeModel?.date ?? DateTime.now(),
        );

  RechargeSaleModel copyRSWith({
    String? clntID,
    String? rSId,
    String? soldRchrgId,
    num? qnttSld,
    DateTime? dateSld,
    RechargeModel? rechargeModel,
    ShopClientModel? shopClientModel,
  }) {
    return RechargeSaleModel(
      clntID: clntID ?? this.clntID,
      rSId: rSId ?? this.rSId,
      soldRchrgId: soldRchrgId ?? this.soldRchrgId,
      qnttSld: qnttSld ?? this.qnttSld,
      dateSld: dateSld ?? this.dateSld,
      rechargeModel: rechargeModel ?? this.rechargeModel,
      shopClientModel: shopClientModel ?? this.shopClientModel,
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  @override

  /// toMap()
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // if (rSId != null) 'rSId': rSId,
      'qnttSld': qnttSld,
      'dateSld': dateSld,
      'clntID': clntID,
      'soldRchrgId': soldRchrgId,
    };
  }

  @override
  RechargeModel copyWith({
    String? id,
    RechargeOperator? oprtr,
    double? percntg,
    double? amount,
    num? qntt,
    DateTime? date,
    String? suplyrID,
  }) {
    return RechargeModel(
      id: id ?? this.id,
      oprtr: oprtr ?? this.oprtr,
      percntg: percntg ?? this.percntg,
      amount: amount ?? this.amount,
      qntt: qntt ?? this.qntt,
      date: date ?? this.date,
    );
  }

  factory RechargeSaleModel.fromDocument(DocumentSnapshot map) {
    return RechargeSaleModel(
      rSId: map.id,
      soldRchrgId: map['soldRchrgId'] ?? '',
      clntID: map['clntID'] ?? '',
      qnttSld: map['qnttSld'] ?? 0,
      dateSld: map['dateSld'].toDate(),
    );
  }

  /// fromMap()
  factory RechargeSaleModel.fromMap(Map<String, dynamic> map) {
    return RechargeSaleModel(
      rSId: map['rchgSlId'] ?? '',
      clntID: map['clntID'] ?? '',
      soldRchrgId: map['soldRchrgId'] ?? '',
      qnttSld: map['qnttSld'] ?? 0,
      dateSld: map['dateSld']?.toDate(),
    );
  }

  @override
  String toJson() => json.encode(toMap());
  factory RechargeSaleModel.fromJson(String source) =>
      RechargeSaleModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  String toString() {
    return 'RechargeSale(clntID: $clntID, rchgSlId: $rSId, qnttSld: $qnttSld, dateSld: $dateSld)';
  }

///////////////////////////////////////////////////////////
  /// get total amount of the sale of the recharge
  /// @return num [amount * quantitySold]total amount of the sale of the recharge

}
