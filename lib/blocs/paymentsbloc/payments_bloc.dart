import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../database/database_operations.dart';
import '../../models/payment/payment.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentEvent, PaymentsState> {
  /// stream subscription to get the products from the database
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<PaymentModel>>? paymentsSubscription;
  PaymentsBloc({required DatabaseOperations databaseOperations})
      : super(const PaymentsState(
          status: PaymentsStatus.initial,
          payments: [],
          error: null,
        )) {
    _databaseOperations = databaseOperations;

    on<GetPaymentsEvent>(_onGetPayments);

    on<LoadPaymentsEvent>(_onLoadPayments);

    on<AddPaymentEvent>(_onAddPayment);
    on<UpdatePaymentEvent>(_onUpdatePayment);
    on<DeletePaymentEvent>(_onDeletePayment);
  }

  /// onloadproducts event
  void _onLoadPayments(
      LoadPaymentsEvent event, Emitter<PaymentsState> emit) async {
    emit(
      PaymentsState(
        status: PaymentsStatus.loaded,
        payments: event.payments,
        error: null,
      ),
    );
  }

  /// on get products event
  Future<void> _onGetPayments(
      PaymentEvent event, Emitter<PaymentsState> emit) async {
    // if (paymentsSubscription != null) {
    // paymentsSubscription!.cancel();
    // }
    paymentsSubscription = _databaseOperations
        .paymentStream()
        .listen((products) => add(LoadPaymentsEvent(products)));
  }

  /// on add payments event
  void _onAddPayment(AddPaymentEvent event, Emitter<PaymentsState> emit) async {
    try {
      await _databaseOperations.addPayment(event.payment);
      emit(
        PaymentsState(
          status: PaymentsStatus.added,
          payment: event.payment,
          payments: state.payments,
          error: null,
        ),
      );
    } catch (error) {
      emit(
        PaymentsState(
          status: PaymentsStatus.error,
          payments: state.payments,
          payment: null,
          error: error.toString(),
        ),
      );
    }
  }

  /// on update payments event
  void _onUpdatePayment(
      UpdatePaymentEvent event, Emitter<PaymentsState> emit) async {
    try {
      await _databaseOperations.updatePayment(event.payment);
      emit(
        PaymentsState(
          status: PaymentsStatus.updated,
          payment: event.payment,
          payments: state.payments,
          error: null,
        ),
      );
    } catch (error) {
      emit(
        PaymentsState(
          status: PaymentsStatus.error,
          payments: state.payments,
          payment: event.payment,
          error: error.toString(),
        ),
      );
    }
  }

  /// on delete payments event
  void _onDeletePayment(
      DeletePaymentEvent event, Emitter<PaymentsState> emit) async {
    try {
      await _databaseOperations.deletePayment(event.payment);
      emit(
        PaymentsState(
          status: PaymentsStatus.deleted,
          payment: event.payment,
          payments: state.payments,
          error: null,
        ),
      );
    } catch (error) {
      emit(
        PaymentsState(
          status: PaymentsStatus.error,
          payments: state.payments,
          payment: event.payment,
          error: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    paymentsSubscription!.cancel();
    return super.close();
  }
}
