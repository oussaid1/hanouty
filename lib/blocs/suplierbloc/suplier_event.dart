part of 'suplier_bloc.dart';

abstract class SupliersEvent extends Equatable {
  const SupliersEvent();

  @override
  List<Object> get props => [];
}

///  get supliers from database
class GetSupliersEvent extends SupliersEvent {}

/// load supliers event
class LoadSupliersEvent extends SupliersEvent {
  final List<SuplierModel> supliers;
  const LoadSupliersEvent(this.supliers);
  @override
  List<Object> get props => [supliers];
}

/// add suplier to database
class AddSupliersEvent extends SupliersEvent {
  final SuplierModel suplier;

  const AddSupliersEvent(this.suplier);

  @override
  List<Object> get props => [suplier];
}

/// Delete suplier from database
class DeleteSupliersEvent extends SupliersEvent {
  final SuplierModel suplier;

  const DeleteSupliersEvent(this.suplier);

  @override
  List<Object> get props => [suplier];
}

/// Update suplier in database
class UpdateSupliersEvent extends SupliersEvent {
  final SuplierModel suplier;

  const UpdateSupliersEvent(this.suplier);

  @override
  List<Object> get props => [suplier];
}
