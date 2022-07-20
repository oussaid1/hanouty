part of 'clients_bloc.dart';

abstract class ShopClientEvent extends Equatable {
  const ShopClientEvent();

  @override
  List<Object> get props => [];
}

///  get clients from database
class GetShopClientsEvent extends ShopClientEvent {}

/// load clients event
class LoadShopClientsEvent extends ShopClientEvent {
  final List<ShopClientModel> clients;
  const LoadShopClientsEvent(this.clients);
  @override
  List<Object> get props => [clients];
}

/// add client to database
class AddShopClientEvent extends ShopClientEvent {
  final ShopClientModel client;

  const AddShopClientEvent(this.client);

  @override
  List<Object> get props => [client];
}

/// Delete client from database
class DeleteShopClientEvent extends ShopClientEvent {
  final ShopClientModel client;

  const DeleteShopClientEvent(this.client);

  @override
  List<Object> get props => [client];
}

/// Update client in database
class UpdateShopClientEvent extends ShopClientEvent {
  final ShopClientModel client;

  const UpdateShopClientEvent(this.client);

  @override
  List<Object> get props => [client];
}
