import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hanouty/blocs/paymentsbloc/payments_bloc.dart';

import '../../components.dart';
import '../../database/database_operations.dart';
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
    this.client,
    required this.payingStatus,
  }) : super(key: key);
  final PaymentModel? payment;
  final PayingStatus payingStatus;
  final DebtModel? debt;
  final ShopClientModel? client;
  @override
  AddPaymentState createState() => AddPaymentState();
}

class AddPaymentState extends State<AddPayment> {
  final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  // final TextEditingController productNameController = TextEditingController();
  final TextEditingController amuontamountController = TextEditingController();
  // final TextEditingController dueAmountController = TextEditingController();
  ShopClientModel? client;
  String description = '';
  DateTime date = DateTime.now();
  bool _canSave = false;
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
      description = widget.payment!.description!;
    }
    if (widget.client != null) {
      client = widget.client;
    }
    if (widget.payingStatus == PayingStatus.paying) {
      client = widget.client;
      amuontamountController.text = widget.debt!.amount.toString();
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
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: dformKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.client == null ? buildClientName() : const SizedBox.shrink(),
            const SizedBox(height: 20),
            buildamountAmount(),
            const SizedBox(height: 20),
            buildDate(),
            const SizedBox(height: 40),
            buildSaveButton(
              context,
            ),
            const SizedBox(height: 100) //but
          ],
        ),
      ),
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
      initialValue: client,
      onChanged: (selectedClient) {
        setState(() {
          client = selectedClient;
          _canSave = true;
        });
      },
    );
  }

  Widget buildSaveButton(BuildContext context) {
    var pymntBloc =
        PaymentsBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !_canSave
                ? null
                : () {
                    // var selectedShopClient = ref.watch(selectedShopClient);
                    if (dformKey.currentState!.validate()) {
                      setState(() {
                        _canSave = false;
                      });
                      if (widget.payingStatus == PayingStatus.editing) {
                        widget.payment!.amount =
                            double.parse(amuontamountController.text);
                        widget.payment!.date = date;
                        widget.payment!.clientId =
                            client?.id ?? widget.payment!.clientId;
                        widget.payment!.description = description;
                        pymntBloc.add(UpdatePaymentEvent(widget.payment!));
                      } else if (widget.payingStatus == PayingStatus.paying) {
                        PaymentModel payment = PaymentModel(
                          clientName: client!.clientName,
                          amount: double.parse(amuontamountController.text),
                          date: date,
                          clientId: widget.debt!.clientId!,
                          description: description,
                        );
                        pymntBloc.add(AddPaymentEvent(payment));
                      } else {
                        PaymentModel payment = PaymentModel(
                          amount: double.parse(amuontamountController.text),
                          date: date,
                          clientId: client!.id!,
                          clientName: client!.clientName,
                          description: description,
                        );
                        pymntBloc.add(AddPaymentEvent(payment));
                      }
                      clear();
                      //Navigator.pop(context);
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
      onDateSelected: (selectedDate) {
        setState(() {
          _canSave = true;
          date = selectedDate;
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
      onChanged: (text) {
        setState(() {
          _canSave = true;
        });
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
