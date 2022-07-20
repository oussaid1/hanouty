part of 'techservice_bloc.dart';

enum TechServiceStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class TechServiceState extends Equatable {
  final TechServiceStatus status;
  final List<TechServiceModel> techservices;
  final TechServiceModel? techservice;
  final String? error;

  const TechServiceState({
    required this.status,
    required this.techservices,
    this.techservice,
    this.error,
  });

  /// copyWith method
  TechServiceState copyWith({
    TechServiceStatus? status,
    List<TechServiceModel>? techservices,
    TechServiceModel? techservice,
    String? error,
  }) {
    return TechServiceState(
      status: status ?? this.status,
      techservices: techservices ?? this.techservices,
      techservice: techservice ?? this.techservice,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, techservices, techservice!, error!];
}
// /// Initial state
// class TechServicesInitial extends TechServiceState {}

// /// Loading state
// class TechServicesLoadingState extends TechServiceState {}

// /// techservices loaded from database
// class TechServicesLoadedState extends TechServiceState {
//   final List<TechServiceModel> techservices;

//   const TechServicesLoadedState(this.techservices);

//   @override
//   List<Object> get props => [techservices];
// }
