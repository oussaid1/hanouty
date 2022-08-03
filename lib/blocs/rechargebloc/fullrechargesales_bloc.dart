import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hanouty/local_components.dart';

import '../../components.dart';
import '../../database/database_operations.dart';
import '../../models/recharge/recharge.dart';

part 'fullrechargesales_event.dart';
part 'fullrechargesales_state.dart';

class RechargeBloc extends Bloc<FullrechargesalesEvent, RechargeState> {
  /// an instance of database operations
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<RechargeModel>>? _rechargesSubscription;
  StreamSubscription<List<RechargeSaleModel>>? _rechargeSalesSubscription;
//final Database
  RechargeBloc({required DatabaseOperations databaseOperations})
      : super(const RechargeState(
          status: FullrechargesalesStatus.initial,
          rechargeList: [],
          rechargeSalesList: [],
          fullRechargeSalesList: [],
        )) {
    _databaseOperations = databaseOperations;
    on<GetFullRechargeSalesEvent>(_onGetSaless);

    on<LoadFullRechargeSalesEvent>(_onLoadSaless);

    on<AddRechargeSaleEvent>(_onAddRechargeSale);
    on<UpdateRechargeSaleEvent>(_onUpdateRechargeSale);
    on<DeleteRechargeSaleEvent>(_onDeleteRechargeSale);
    ////////////////////////////////////////////////////
    on<AddRechargeEvent>(_onAddRecharge);
    on<UpdateRechargeEvent>(_onUpdateRecharge);
    on<DeleteRechargeEvent>(_onDeleteRecharge);
  }

  /// onloadproducts event
  void _onLoadSaless(
      LoadFullRechargeSalesEvent event, Emitter<RechargeState> emit) async {
    emit(state.copyWith(
      status: FullrechargesalesStatus.loaded,
      rechargeList: event.rechargeList,
      rechargeSalesList: event.rechargeSalesList,
      fullRechargeSalesList: event.fullRechargeSalesList,
    ));
  }

  /// on get products event
  Future<void> _onGetSaless(
      FullrechargesalesEvent event, Emitter<RechargeState> emit) async {
    // if (_productsSubscription != null) {
    // _productsSubscription!.cancel();
    // }
    _rechargesSubscription =
        _databaseOperations.rechargeStream().listen((recharges) {
      // log('products stream : $products');
      _rechargeSalesSubscription =
          _databaseOperations.rechargeSaleStream().listen((rechargeSales) {
        add(LoadFullRechargeSalesEvent(
          status: FullrechargesalesStatus.loaded,
          rechargeList: recharges,
          rechargeSalesList: rechargeSales,
          fullRechargeSalesList:
              rechargeSales.combineWithRechargeModel(recharges),
        ));
      });
    });
  }

  /// on add recharge event
  Future<void> _onAddRecharge(
      AddRechargeEvent event, Emitter<RechargeState> emit) async {
    await _databaseOperations.addRecharge(event.rechargeModel);
    add(GetFullRechargeSalesEvent());
  }

  /// on update recharge event
  Future<void> _onUpdateRecharge(
      UpdateRechargeEvent event, Emitter<RechargeState> emit) async {
    await _databaseOperations.updateRecharge(event.rechargeModel);
    add(GetFullRechargeSalesEvent());
  }

  /// on delete recharge event
  Future<void> _onDeleteRecharge(
      DeleteRechargeEvent event, Emitter<RechargeState> emit) async {
    await _databaseOperations.deleteRecharge(event.rechargeModel);
    add(GetFullRechargeSalesEvent());
  }

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
  /// on add recharge sale event
  Future<void> _onAddRechargeSale(
      AddRechargeSaleEvent event, Emitter<RechargeState> emit) async {
    await _databaseOperations.addRechargeSale(event.rechargeSale);
    add(GetFullRechargeSalesEvent());
  }

  /// on update recharge sale event
  Future<void> _onUpdateRechargeSale(
      UpdateRechargeSaleEvent event, Emitter<RechargeState> emit) async {
    await _databaseOperations.updateRechargeSale(event.rechargeSale);
    add(GetFullRechargeSalesEvent());
  }

  /// on delete recharge sale event
  Future<void> _onDeleteRechargeSale(
      DeleteRechargeSaleEvent event, Emitter<RechargeState> emit) async {
    await _databaseOperations.deleteRechargeSale(event.rechargeSale);
    add(GetFullRechargeSalesEvent());
  }

  @override
  Future<void> close() async {
    _rechargesSubscription!.cancel();
    _rechargeSalesSubscription!.cancel();
    super.close();
  }
}
