part of 'suplier_bloc.dart';

enum SuplierStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class SuplierState extends Equatable {
  final SuplierStatus status;
  final List<SuplierModel> supliers;
  final SuplierModel? suplier;
  final String? error;

  const SuplierState({
    this.status = SuplierStatus.initial,
    this.supliers = const [],
    this.suplier,
    this.error,
  });

  /// copyWith method
  SuplierState copyWith({
    SuplierStatus? status,
    List<SuplierModel>? supliers,
    SuplierModel? suplier,
    String? error,
  }) {
    return SuplierState(
      status: status ?? this.status,
      supliers: supliers ?? this.supliers,
      suplier: suplier ?? this.suplier,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, supliers, suplier!, error!];
}
// /// Loading state
// class SuplierssLoadingState extends SupliersState {}

// /// supliers loaded from database
// class SupliersLoadedState extends SupliersState {
//   final List<SuplierModel> supliers;

//   const SupliersLoadedState(this.supliers);

//   @override
//   List<Object> get props => [supliers];
// }
