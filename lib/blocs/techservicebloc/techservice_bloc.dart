import 'dart:async';

import 'package:hanouty/models/techservice/techservice.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
part 'techservice_event.dart';
part 'techservice_state.dart';

class TechServiceBloc extends Bloc<TechServiceEvent, TechServiceState> {
  /// stream subscription to get the techservices from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<TechServiceModel>>? _techservicesSubscription;
  TechServiceBloc({required DatabaseOperations databaseOperations})
      : super(const TechServiceState(
          status: TechServiceStatus.initial,
          techservices: [],
          error: null,
        )) {
    _databaseOperations = databaseOperations;

    on<GetTechServiceEvent>(_onGetTechServices);

    on<LoadTechServiceEvent>(_onLoadTechServices);

    /// on add techservice event
    on<AddTechServiceEvent>(_onAddTechService);
    on<UpdateTechServiceEvent>(_onUpdateTechService);
    on<DeleteTechServiceEvent>(_onDeleteTechService);
  }

  /// onloadtechservices event
  void _onLoadTechServices(
      LoadTechServiceEvent event, Emitter<TechServiceState> emit) async {
    emit(TechServiceState(
      status: TechServiceStatus.loaded,
      techservices: event.techservices,
      error: null,
    ));
  }

  /// on get techservices event
  Future<void> _onGetTechServices(
      TechServiceEvent event, Emitter<TechServiceState> emit) async {
    // if (_techservicesSubscription != null) {
    // _techservicesSubscription!.cancel();
    // }
    _techservicesSubscription = _databaseOperations
        .techServiceStream()
        .listen((techservices) => add(LoadTechServiceEvent(techservices)));
  }

  /// on add techservice event
  Future<void> _onAddTechService(
      AddTechServiceEvent event, Emitter<TechServiceState> emit) async {
    try {
      await _databaseOperations.addTechService(event.techservice);
      emit(
        TechServiceState(
          status: TechServiceStatus.added,
          techservices: state.techservices,
        ),
      );
    } catch (error) {
      emit(
        TechServiceState(
          status: TechServiceStatus.error,
          techservices: state.techservices,
          error: error.toString(),
        ),
      );
    }
  }

  /// on update techservice event
  Future<void> _onUpdateTechService(
      UpdateTechServiceEvent event, Emitter<TechServiceState> emit) async {
    try {
      await _databaseOperations.updateTechService(event.techservice);
      emit(
        TechServiceState(
          status: TechServiceStatus.updated,
          techservices: state.techservices,
        ),
      );
    } catch (error) {
      emit(
        TechServiceState(
          status: TechServiceStatus.error,
          techservices: state.techservices,
          error: error.toString(),
        ),
      );
    }
  }

  /// on delete techservice event
  Future<void> _onDeleteTechService(
      DeleteTechServiceEvent event, Emitter<TechServiceState> emit) async {
    try {
      await _databaseOperations.deleteTechService(event.techservice);
      emit(
        TechServiceState(
          status: TechServiceStatus.deleted,
          techservices: state.techservices,
        ),
      );
    } catch (error) {
      emit(
        TechServiceState(
          status: TechServiceStatus.error,
          techservices: state.techservices,
          error: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _techservicesSubscription!.cancel();
    return super.close();
  }
}
