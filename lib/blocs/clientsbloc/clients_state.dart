part of 'clients_bloc.dart';

enum ShopClientsStatus {
  initial,
  //loading,
  loaded,
  //adding,
  added,
  //updating,
  updated,
  //deleting,
  deleted,
  error,
}

class ShopClientState extends Equatable {
  const ShopClientState({
    this.status = ShopClientsStatus.initial,
    this.clients = const [],
    this.client,
    this.error,
  });
  final ShopClientsStatus status;
  final List<ShopClientModel> clients;
  final ShopClientModel? client;
  final String? error;

  /// copyWith method
  ShopClientState copyWith({
    ShopClientsStatus? status,
    List<ShopClientModel>? clients,
    ShopClientModel? client,
    String? error,
  }) {
    return ShopClientState(
      status: status ?? this.status,
      clients: clients ?? this.clients,
      client: client ?? this.client,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        status,
        clients,
      ];
}

// /// Initial state
// class ShopClientsInitial extends ShopClientState {}

// /// Loading state
// class ShopClientsLoadingState extends ShopClientState {}

// /// products loaded from database
// class ShopClientsLoadedState extends ShopClientState {
//   final List<ShopClientModel> products;

//   const ShopClientsLoadedState(this.products);

//   @override
//   List<Object> get props => [products];
// }

// /// ShopClient added to database
// class ShopClientAddedState extends ShopClientState {}

// /// ShopClient updated in database
// class ShopClientUpdatedState extends ShopClientState {}

// /// ShopClient deleted from database
// class ShopClientDeletedState extends ShopClientState {}

// /// ShopClient error state
// class ShopClientErrorState extends ShopClientState {
//   final String error;

//   const ShopClientErrorState(this.error);

//   @override
//   List<Object> get props => [error];
// }
