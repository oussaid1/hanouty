import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../components.dart';
import '../../database/database_operations.dart';
import '../../models/debt/debt.dart';
import '../../settings/themes.dart';
import '../../widgets/autocomplete/autocomlete_textfields.dart';
import '../../widgets/date_pickers.dart/date_picker.dart';

class AddDebt extends StatefulWidget {
  const AddDebt({Key? key, this.debt}) : super(key: key);
  final DebtModel? debt;

  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddDebt> {
  final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  final TextEditingController paidAmountController = TextEditingController();
  String productId = "any";
  final TextEditingController dueAmountController = TextEditingController();
  DateTime date = DateTime.now();
  DateTime deadline = DateTime.now().add(const Duration(days: 30));
  String clientId = "";
  String type = "";
  bool _canSave = false;
  bool _isUpdate = false;

  /// clear the controller when the user clicks on the field
  void clear() {
    paidAmountController.clear();
    dueAmountController.clear();
  }

  /// initialize the controller with the debt's data
  void initialize() {
    super.initState();
    if (widget.debt != null) {
      _isUpdate = true;
      date = widget.debt!.timeStamp;
      deadline = widget.debt!.deadLine;
      dueAmountController.text = widget.debt!.amount.toString();
      clientId = widget.debt!.clientId!;
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var clientNamesLis = ref.watch(shopClientsProvider.state).state;
    // var productCatList = ref.watch(productCategoryListProvider.state).state;
    // var productsList = context.read<ProductBloc>().state;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: dformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildClientName(),
              const SizedBox(height: 20),
              buildDueDate(),
              const SizedBox(height: 20),
              buildDueAmount(),
              // const SizedBox(height: 20),
              // buildProductId(context),
              const SizedBox(height: 20),
              buildDate(),
              const SizedBox(height: 20),
              // buildPaidAmount(),
              // const SizedBox(height: 40),
              buildSaveButton(context),
              const SizedBox(height: 40) //but
            ],
          ),
        ),
      ),
    );
  }

  buildSaveButton(BuildContext context) {
    var debtBloc = DebtBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !_canSave
                ? null
                : () {
                    if (dformKey.currentState!.validate()) {
                      setState(() {
                        _canSave = false;
                      });
                      final debt = DebtModel(
                        id: _isUpdate ? widget.debt!.id : null,
                        amount: double.tryParse(dueAmountController.text)!,
                        clientId: _isUpdate ? widget.debt!.clientId : clientId,
                        deadLine: deadline,
                        timeStamp: date,
                      );
                      debtBloc.add(_isUpdate
                          ? UpdateDebtEvent(debt)
                          : AddDebtEvent(debt));
                      log("debt: $debt");
                      clear();
                      // Navigator.pop(context);
                    }
                  },
            child: Text(_isUpdate ? "Update" : "Save").tr()),
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

  Widget buildDueDate() {
    return SelectDate(
      labelText: 'Deadline Date'.tr(),
      initialDate: deadline,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      onDateSelected: (value) {
        deadline = value;
      },
    );
  }

  Widget buildDate() {
    return SelectDate(
      initialDate: date,
      onDateSelected: (value) {
        setState(() {
          date = value;
        });
      },
    );
  }

  TextFormField buildDueAmount() {
    return TextFormField(
      controller: dueAmountController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Amount-Due'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '1434 dh',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on),
        filled: true,
      ),
    );
  }

  buildProductId(BuildContext context) {
    return ProductsAutoCompleteWidget(
      onChanged: (product) {
        setState(() {
          productId = product.pId!;
        });
      },
    );
  }

  TextFormField buildPaidAmount() {
    return TextFormField(
      controller: paidAmountController,
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
        labelText: 'Amount-Paid'.tr(),
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

  buildClientName() {
    return ClientsAutocompleteWidget(
      // validator: (client) {
      //   if (client == null) {
      //     return "error".tr();
      //   }
      //   return null;
      // },
      initialValue: _isUpdate ? widget.debt!.clientId! : null,
      onChanged: (client) {
        setState(() {
          clientId = client.id!;
          _canSave = true;
        });
      },
    );
  }
}
