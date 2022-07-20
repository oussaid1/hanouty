import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/database_operations.dart';
import '../../models/client/shop_client.dart';
part 'clients_event.dart';
part 'clients_state.dart';

class ShopClientBloc extends Bloc<ShopClientEvent, ShopClientState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<ShopClientModel>>? _shopClientsSubscription;
  ShopClientBloc({required DatabaseOperations databaseOperations})
      : super(const ShopClientState(
          status: ShopClientsStatus.initial,
          clients: [],
          client: null,
          error: null,
        )) {
    _databaseOperations = databaseOperations;

    on<GetShopClientsEvent>(_onGetShopClients);

    on<LoadShopClientsEvent>(_onLoadShopClients);

    on<AddShopClientEvent>(_onAddShopClient);
    on<UpdateShopClientEvent>(_onUpdateShopClient);
    on<DeleteShopClientEvent>(_onDeleteShopClient);
  }

  /// onloadproducts event
  void _onLoadShopClients(
      LoadShopClientsEvent event, Emitter<ShopClientState> emit) async {
    emit(ShopClientState(
      status: ShopClientsStatus.loaded,
      clients: event.clients,
      client: null,
      error: null,
    ));
  }

  /// on get products event
  Future<void> _onGetShopClients(
      ShopClientEvent event, Emitter<ShopClientState> emit) async {
    // if (_shopClientsSubscription != null) {
    // _shopClientsSubscription!.cancel();
    // }
    _shopClientsSubscription = _databaseOperations
        .clientsStream()
        .listen((products) => add(LoadShopClientsEvent(products)));
  }

  /// on add Client event
  void _onAddShopClient(
      AddShopClientEvent event, Emitter<ShopClientState> emit) async {
    _databaseOperations.addClient(event.client);
    emit(ShopClientState(
      status: ShopClientsStatus.added,
      clients: state.clients,
      client: event.client,
      error: null,
    ));
    add(GetShopClientsEvent());
  }

  /// on update product event
  void _onUpdateShopClient(
      UpdateShopClientEvent event, Emitter<ShopClientState> emit) async {
    _databaseOperations.updateClient(event.client);
    add(GetShopClientsEvent());
  }

  /// on delete product event
  void _onDeleteShopClient(
      DeleteShopClientEvent event, Emitter<ShopClientState> emit) async {
    _databaseOperations.deleteClient(event.client);
    emit(ShopClientState(
      status: ShopClientsStatus.deleted,
      clients: state.clients,
      client: event.client,
      error: null,
    ));
  }

  /// on dispose event
  @override
  Future<void> close() {
    _shopClientsSubscription!.cancel();
    return super.close();
  }
}
