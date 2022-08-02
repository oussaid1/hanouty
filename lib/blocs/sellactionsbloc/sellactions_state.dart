part of 'sellactions_bloc.dart';

enum SellActionsStatus {
  initial,
  sellig,
  sold,
  unselling,
  unsold,
  error,
}

class SellActionsState extends Equatable {
  const SellActionsState({
    this.status = SellActionsStatus.initial,
    this.soldProduct,
    this.errorMessage,
  });
  final ProductModel? soldProduct;
  final String? errorMessage;
  final SellActionsStatus status;

  /// copywith
  SellActionsState copyWith({
    SellActionsStatus? status,
    ProductModel? soldProduct,
    String? errorMessage,
  }) {
    return SellActionsState(
      status: status ?? this.status,
      soldProduct: soldProduct ?? this.soldProduct,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status];
}
