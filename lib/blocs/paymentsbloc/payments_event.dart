part of 'payments_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

///  get payments from database
class GetPaymentsEvent extends PaymentEvent {}

/// load payments event
class LoadPaymentsEvent extends PaymentEvent {
  final List<PaymentModel> payments;
  const LoadPaymentsEvent(this.payments);
  @override
  List<Object> get props => [payments];
}

/// add payment to database
class AddPaymentEvent extends PaymentEvent {
  final PaymentModel payment;

  const AddPaymentEvent(this.payment);

  @override
  List<Object> get props => [payment];
}

/// Delete payment from database
class DeletePaymentEvent extends PaymentEvent {
  final PaymentModel payment;

  const DeletePaymentEvent(this.payment);

  @override
  List<Object> get props => [payment];
}

/// Update payment in database
class UpdatePaymentEvent extends PaymentEvent {
  final PaymentModel payment;

  const UpdatePaymentEvent(this.payment);

  @override
  List<Object> get props => [payment];
}
