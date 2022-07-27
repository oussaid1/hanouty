import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hanouty/blocs/paymentsbloc/payments_bloc.dart';

import '../../models/client/shop_client.dart';
import '../../models/debt/debt.dart';
import '../../models/payment/payment.dart';
import '../../settings/themes.dart';
import '../../widgets/autocomplete/autocomlete_textfields.dart';
import '../../widgets/date_pickers.dart/date_picker.dart';

/// these are the states of the add payment screen //to disable the client name  if the payment is paying
/// and to show only minumum fields if the payment is paying

enum PayingStatus {
  editing,
  adding,
  paying,
}

class AddPayment extends StatefulWidget {
  const AddPayment({
    Key? key,
    this.payment,
    this.debt,
    required this.payingStatus,
  }) : super(key: key);
  final PaymentModel? payment;
  final PayingStatus payingStatus;
  final DebtModel? debt;
  @override
  AddPaymentState createState() => AddPaymentState();
}

class AddPaymentState extends State<AddPayment> {
  final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  // final TextEditingController productNameController = TextEditingController();
  final TextEditingController amuontamountController = TextEditingController();
  // final TextEditingController dueAmountController = TextEditingController();
  String clientId = '';
  ShopClientModel? client;
  String description = '';
  DateTime date = DateTime.now();
  bool canSave = false;
  void clear() {
    // productNameController.clear();
    amuontamountController.clear();
    //_dueAmountController.clear();
  }

  @override
  void initState() {
    if (widget.payingStatus == PayingStatus.editing) {
      amuontamountController.text = widget.payment!.amount.toString();
      date = widget.payment!.date;
      clientId = widget.payment!.clientId;

      description = widget.payment!.description!;
    }
    if (widget.payingStatus == PayingStatus.paying) {
      amuontamountController.text = widget.debt!.amount.toString();
      clientId = widget.debt!.clientId!;
    }
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: dformKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.payingStatus != PayingStatus.paying
                    ? buildClientName()
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                buildamountAmount(),
                const SizedBox(height: 20),
                buildDate(),
                const SizedBox(height: 40),
                buildSaveButton(
                  context,
                ),
                const SizedBox(
                  height: 100,
                ) //but
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildClientName() {
    return ClientsAutocompleteWidget(
      // validator: (value) {
      //   if (client == null) {
      //     return 'client_name_is_required';
      //   }
      //   return null;
      // },
      onChanged: (selectedClient) {
        setState(() {
          client = selectedClient;
          canSave = true;
          clientId = selectedClient.id!;
        });
      },
    );
  }

  Widget buildSaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !canSave
                ? null
                : () {
                    // var selectedShopClient = ref.watch(selectedShopClient);
                    if (dformKey.currentState!.validate()) {
                      setState(() {
                        canSave = false;
                      });
                      if (widget.payingStatus == PayingStatus.editing) {
                        widget.payment!.amount =
                            double.parse(amuontamountController.text);
                        widget.payment!.date = date;
                        widget.payment!.clientId = clientId;
                        widget.payment!.description = description;
                        context
                            .read<PaymentsBloc>()
                            .add(AddPaymentEvent(widget.payment!));
                      } else if (widget.payingStatus == PayingStatus.paying) {
                        widget.debt!.amount =
                            double.parse(amuontamountController.text);
                        widget.debt!.clientId = clientId;
                        context
                            .read<PaymentsBloc>()
                            .add(UpdatePaymentEvent(widget.payment!));
                      } else {
                        PaymentModel payment = PaymentModel(
                          amount: double.parse(amuontamountController.text),
                          date: date,
                          clientId: clientId,
                          description: description,
                        );
                        context
                            .read<PaymentsBloc>()
                            .add(AddPaymentEvent(payment));
                      }
                      Navigator.pop(context);
                    }
                  },
            child: Text(widget.payingStatus == PayingStatus.editing
                ? 'update'
                : 'save')),
        ElevatedButton(
          style: MThemeData.raisedButtonStyleCancel,
          child: Text('Cancel'.tr()),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget buildDate() {
    return SelectDate(
      onDateSelected: (date) {
        setState(() {
          date = date;
        });
      },
    );
  }

  TextFormField buildamountAmount() {
    return TextFormField(
      controller: amuontamountController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      textAlign: TextAlign.center,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Amount-amount'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '1234 \$',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: true,
      ),
    );
  }

  // TextFormField buildClientName(WidgetRef ref) {
  //   return TextFormField(
  //     controller: clientController,
  //     validator: (text) {
  //       if (text!.trim().isEmpty) {
  //         return "error".tr();
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: 'client name'.tr(),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(6.0),
  //         borderSide: const BorderSide(),
  //       ),
  //       hintText: 'client name',
  //       hintStyle:Theme.of(context).textTheme.subtitle2!,
  //       contentPadding: const EdgeInsets.only(top: 4),
  //       prefixIcon: const Icon(Icons.badge_rounded),
  //       filled: true,
  //     ),
  //   );
  // }
}
