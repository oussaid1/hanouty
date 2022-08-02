part of 'fullrechargesales_bloc.dart';

abstract class FullrechargesalesEvent extends Equatable {
  const FullrechargesalesEvent();

  @override
  List<Object> get props => [];
}

/// get full recharge sales event
/// This event is used to get full recharge sales.
class GetFullRechargeSalesEvent extends FullrechargesalesEvent {}

/// load FullRechargeSales
class LoadFullRechargeSalesEvent extends FullrechargesalesEvent {
  final List<RechargeModel> rechargeList;
  final List<RechargeSaleModel> rechargeSalesList;
  final List<RechargeSaleModel> fullRechargeSalesList;
  final FullrechargesalesStatus status;
  const LoadFullRechargeSalesEvent({
    required this.status,
    required this.rechargeList,
    required this.rechargeSalesList,
    required this.fullRechargeSalesList,
  });
}

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
/// add recharge  event
/// This event is used to add recharge.
class AddRechargeSaleEvent extends FullrechargesalesEvent {
  final RechargeSaleModel rechargeSale;
  const AddRechargeSaleEvent({required this.rechargeSale});
}

class UpdateRechargeSaleEvent extends FullrechargesalesEvent {
  final RechargeSaleModel rechargeSale;
  const UpdateRechargeSaleEvent({required this.rechargeSale});
}

class DeleteRechargeSaleEvent extends FullrechargesalesEvent {
  final RechargeSaleModel rechargeSale;
  const DeleteRechargeSaleEvent({required this.rechargeSale});
}

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
class AddRechargeEvent extends FullrechargesalesEvent {
  final RechargeModel rechargeModel;
  const AddRechargeEvent({required this.rechargeModel});
}

class UpdateRechargeEvent extends FullrechargesalesEvent {
  final RechargeModel rechargeModel;
  const UpdateRechargeEvent({required this.rechargeModel});
}

class DeleteRechargeEvent extends FullrechargesalesEvent {
  final RechargeModel rechargeModel;
  const DeleteRechargeEvent({required this.rechargeModel});
}
