import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
import '../../models/suplier/suplier.dart';
part 'suplier_event.dart';
part 'suplier_state.dart';

class SuplierBloc extends Bloc<SupliersEvent, SuplierState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<SuplierModel>>? _supliersSubscription;
  SuplierBloc({required DatabaseOperations databaseOperations})
      : super(
          const SuplierState(
            status: SuplierStatus.initial,
            supliers: [],
            error: null,
          ),
        ) {
    _databaseOperations = databaseOperations;

    on<GetSupliersEvent>(_onGetSupliers);

    on<LoadSupliersEvent>(_onLoadSupliers);

    /// on add suplier event
    on<AddSupliersEvent>(_onAddSuplier);
    on<UpdateSupliersEvent>(_onUpdateSuplier);
    on<DeleteSupliersEvent>(_onDeleteSuplier);
  }

  /// onloadproducts event
  Future<void> _onLoadSupliers(
      LoadSupliersEvent event, Emitter<SuplierState> emit) async {
    emit(SuplierState(status: SuplierStatus.loaded, supliers: event.supliers));
  }

  /// on get products event
  Future<void> _onGetSupliers(
      SupliersEvent event, Emitter<SuplierState> emit) async {
    // if (_supliersSubscription != null) {
    // _supliersSubscription!.cancel();
    // }
    _supliersSubscription = _databaseOperations
        .supliersStream()
        .listen((supliers) => add(LoadSupliersEvent(supliers)));
  }

  /// on add suplier event
  Future<void> _onAddSuplier(
      AddSupliersEvent event, Emitter<SuplierState> emit) async {
    try {
      await _databaseOperations.addSuplier(event.suplier);
      emit(
        SuplierState(
          status: SuplierStatus.added,
          supliers: state.supliers,
          suplier: event.suplier,
          error: null,
        ),
      );
    } catch (error) {
      emit(
        SuplierState(
          status: SuplierStatus.error,
          supliers: state.supliers,
          suplier: event.suplier,
          error: error.toString(),
        ),
      );
    }
  }

  /// on update suplier event
  Future<void> _onUpdateSuplier(
      UpdateSupliersEvent event, Emitter<SuplierState> emit) async {
    try {
      await _databaseOperations.updateSuplier(event.suplier);
      emit(
        SuplierState(
          status: SuplierStatus.updated,
          supliers: state.supliers,
          suplier: event.suplier,
          error: null,
        ),
      );
    } catch (error) {
      emit(
        SuplierState(
          status: SuplierStatus.error,
          supliers: state.supliers,
          suplier: event.suplier,
          error: error.toString(),
        ),
      );
    }
  }

  /// on delete suplier event
  Future<void> _onDeleteSuplier(
      DeleteSupliersEvent event, Emitter<SuplierState> emit) async {
    try {
      await _databaseOperations.deleteSuplier(event.suplier);
      emit(
        SuplierState(
          status: SuplierStatus.deleted,
          supliers: state.supliers,
          suplier: event.suplier,
          error: null,
        ),
      );
    } catch (error) {
      emit(
        SuplierState(
          status: SuplierStatus.error,
          supliers: state.supliers,
          suplier: event.suplier,
          error: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _supliersSubscription!.cancel();
    return super.close();
  }
}
