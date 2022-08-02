part of 'sellactionsrecharge_bloc.dart';

abstract class SellActionsrechargeEvent extends Equatable {
  const SellActionsrechargeEvent();

  @override
  List<Object> get props => [];
}

/// selling requested event

class SellRechargeRequestedEvent extends SellActionsrechargeEvent {
  final RechargeModel rechargeModel;
  final RechargeSaleModel rechargeSaleModel;
  num get reducedQuantity => rechargeModel.qntt - rechargeSaleModel.qnttSld;
  const SellRechargeRequestedEvent(
      {required this.rechargeModel, required this.rechargeSaleModel});
  @override
  List<Object> get props => [rechargeModel, rechargeSaleModel];
}

/// unselling recharge requested event
class UnsellRechargeRequestedEvent extends SellActionsrechargeEvent {
  final RechargeModel rechargeModel;
  final RechargeSaleModel rechargeSaleModel;
  const UnsellRechargeRequestedEvent(
      {required this.rechargeModel, required this.rechargeSaleModel});
  @override
  List<Object> get props => [rechargeModel, rechargeSaleModel];
}
