import 'package:hanouty/local_components.dart';
import 'package:hanouty/models/payment/payment.dart';

import 'package:hanouty/widgets/date_pickers.dart/date_picker.dart';
import 'package:hanouty/widgets/spinners/client_spinner.dart';
import 'package:flutter/services.dart';
import '../../blocs/paymentsbloc/payments_bloc.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

enum PayingStatus {
  editing,
  saving,
  paying,
}

class AddPayment extends ConsumerStatefulWidget {
  const AddPayment({Key? key, this.payment, required this.payingStatus})
      : super(key: key);
  final PaymentModel? payment;

  final PayingStatus payingStatus;
  @override
  AddPaymentState createState() => AddPaymentState();
}

class AddPaymentState extends ConsumerState<AddPayment> {
  final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  // final TextEditingController productNameController = TextEditingController();
  final TextEditingController amuontamountController = TextEditingController();
  // final TextEditingController dueAmountController = TextEditingController();

  void clear() {
    // productNameController.clear();
    amuontamountController.clear();
    //_dueAmountController.clear();
  }

  @override
  void initState() {
    if (widget.payment != null) {
      //  productNameController.text = widget.payment!.productName!;
      amuontamountController.text = widget.payment!.amount.toString();
      //_dueAmountController.text = widget.payment!.amount.toString();
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
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(8),
                width: Responsive.isDesktop(context) ? 600 : context.width - 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  //color: Theme.of(context).colorScheme.onBackground,
                ),
                child: Form(
                  key: dformKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildClientName(ref, []),

                        const SizedBox(height: 20),
                        buildamountAmount(ref),
                        const SizedBox(height: 20),
                        buildDate(),
                        const SizedBox(height: 40),
                        buildSaveButton(
                          ref,
                          context,
                        ),
                        const SizedBox(
                          height: 100,
                        ) //but
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildClientName(
    WidgetRef ref,
    List<ShopClientModel> list,
  ) {
    return ClientSpinnerWidget(
      onChanged: (value) {},
      list: list,
    );
  }

  Widget buildSaveButton(WidgetRef ref, BuildContext context) {
    if (widget.payingStatus == PayingStatus.editing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: MThemeData.raisedButtonStyleSave,
              child: Text(
                'Update'.tr(),
              ),
              onPressed: () {
                // var selectedShopClient = ref.watch(selectedShopClient);
                if (dformKey.currentState!.validate()) {
                  final payment = PaymentModel(
                    id: widget.payment!.id,
                    description: widget.payment!.description,
                    amount: double.tryParse(amuontamountController.text)!,
                    clientName: widget.payment!.clientName,
                    clientId: widget.payment!.clientId,
                    date: widget.payment!.date,
                  );

                  GetIt.I<PaymentsBloc>().add(UpdatePaymentEvent(payment));
                  Navigator.pop(context);
                }
              }),
          ElevatedButton(
            style: MThemeData.raisedButtonStyleCancel,
            child: Text(
              'Cancel'.tr(),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
    if (widget.payingStatus == PayingStatus.saving) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: MThemeData.raisedButtonStyleSave,
              child: Text(
                'Save'.tr(),
              ),
              onPressed: () {
                if (dformKey.currentState!.validate()) {
                  // final payment = Payment(
                  //   amount: double.tryParse(amuontamountController.text)!,
                  //   clientName:
                  //       ref.read(selectedShopClient.state).state!.clientName,
                  //   clientId: ref.read(selectedShopClient.state).state!.id!,
                  //   date: ref.read(pickedDateTime.state).state,
                  // );
                  // ref.read(databaseProvider)!.addPayment(payment).then((value) {
                  //   if (value) {
                  //     ScaffoldMessenger.of(context)
                  //         .showSnackBar(MDialogs.snackBar('Done !'));
                  //     clear();
                  //     Navigator.of(context).pop();
                  //   } else {
                  //     ScaffoldMessenger.of(context)
                  //         .showSnackBar(MDialogs.errorSnackBar('Error !'));
                  //   }
                  // });
                }
              }),
          ElevatedButton(
            style: MThemeData.raisedButtonStyleCancel,
            child: Text(
              'Cancel'.tr(),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
    if (widget.payingStatus == PayingStatus.paying) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: MThemeData.raisedButtonStyleSave,
              child: Text(
                'Pay'.tr(),
              ),
              onPressed: () {
                // var selectedShopClient = ref.watch(selectedShopClient);
                if (dformKey.currentState!.validate()) {
                  // final payment = Payment(
                  //   // id: widget.payment!.id,
                  //   description: widget.payment!.description,
                  //   amount: double.tryParse(amuontamountController.text)!,
                  //   clientName: widget.payment!.clientName,
                  //   clientId: widget.payment!.clientId,
                  //   date: widget.payment!.date,
                  // );

                  // ref.read(databaseProvider)!.addPayment(payment).then((value) {
                  //   if (value) {
                  //     ScaffoldMessenger.of(context)
                  //         .showSnackBar(MDialogs.snackBar('Done !'));
                  //     clear();
                  //     Navigator.of(context).pop();
                  //   } else {
                  //     ScaffoldMessenger.of(context)
                  //         .showSnackBar(MDialogs.errorSnackBar('Error !'));
                  //   }
                  // });
                }
              }),
          ElevatedButton(
            style: MThemeData.raisedButtonStyleCancel,
            child: Text(
              'Cancel'.tr(),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget buildDate() {
    return SizedBox(
      height: 50,
      width: 240,
      child: SelectDate(
        onDateSelected: (date) {
          setState(() {
            date = date;
          });
        },
      ),
    );
  }

  TextFormField buildamountAmount(WidgetRef ref) {
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
      decoration: InputDecoration(
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
