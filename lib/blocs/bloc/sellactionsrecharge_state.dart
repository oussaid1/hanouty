part of 'sellactionsrecharge_bloc.dart';

enum SellactionsrechargeStatus {
  initial,
  sold,
  unsold,
  error,
}

class SellactionsRechargeState extends Equatable {
  final SellactionsrechargeStatus status;
  final RechargeModel? soldRecharge;
  final String? errorMessage;
  const SellactionsRechargeState({
    this.status = SellactionsrechargeStatus.initial,
    this.soldRecharge,
    this.errorMessage,
  });

  /// copyWith
  SellactionsRechargeState copyWith({
    SellactionsrechargeStatus? status,
    RechargeModel? soldRecharge,
    String? errorMessage,
  }) {
    return SellactionsRechargeState(
      status: status ?? this.status,
      soldRecharge: soldRecharge ?? this.soldRecharge,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status];
}
