part of 'payments_bloc.dart';

enum PaymentsStatus {
  initial,
  loaded,
  added,
  updated,
  deleted,
  error,
}

class PaymentsState extends Equatable {
  final PaymentsStatus status;
  final List<PaymentModel> payments;
  final PaymentModel? payment;
  final String? error;

  const PaymentsState({
    required this.status,
    required this.payments,
    this.payment,
    this.error,
  });

  /// copyWith method
  PaymentsState copyWith({
    PaymentsStatus? status,
    List<PaymentModel>? payments,
    PaymentModel? payment,
    String? error,
  }) {
    return PaymentsState(
      status: status ?? this.status,
      payments: payments ?? this.payments,
      payment: payment ?? this.payment,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, payments, payment!, error!];
}
