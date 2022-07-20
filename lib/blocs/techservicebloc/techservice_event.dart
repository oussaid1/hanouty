part of 'techservice_bloc.dart';

abstract class TechServiceEvent extends Equatable {
  const TechServiceEvent();

  @override
  List<Object> get props => [];
}

///  get techservices from database
class GetTechServiceEvent extends TechServiceEvent {}

/// load techservices event
class LoadTechServiceEvent extends TechServiceEvent {
  final List<TechServiceModel> techservices;
  const LoadTechServiceEvent(this.techservices);
  @override
  List<Object> get props => [techservices];
}

/// add techservice to database
class AddTechServiceEvent extends TechServiceEvent {
  final TechServiceModel techservice;

  const AddTechServiceEvent(this.techservice);

  @override
  List<Object> get props => [techservice];
}

/// Delete techservice from database
class DeleteTechServiceEvent extends TechServiceEvent {
  final TechServiceModel techservice;

  const DeleteTechServiceEvent(this.techservice);

  @override
  List<Object> get props => [techservice];
}

/// Update techservice in database
class UpdateTechServiceEvent extends TechServiceEvent {
  final TechServiceModel techservice;

  const UpdateTechServiceEvent(this.techservice);

  @override
  List<Object> get props => [techservice];
}
