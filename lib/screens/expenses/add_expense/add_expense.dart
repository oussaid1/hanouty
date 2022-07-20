import 'package:hanouty/local_components.dart';

import 'package:hanouty/widgets/date_pickers.dart/date_picker.dart';
import 'package:hanouty/widgets/date_pickers.dart/due_date_picker.dart';
import 'package:hanouty/widgets/spinners/spinner_widget.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import 'package:flutter/services.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({Key? key, this.expense}) : super(key: key);
  final ExpenseModel? expense;
  @override
  ConsumerState<AddExpense> createState() => AddExpenseState();
}

class AddExpenseState extends ConsumerState<AddExpense> {
  final expenseformKey = GlobalKey<FormState>();
  final expenseformKey2 = GlobalKey<FormState>();
  final TextEditingController expenseNameController = TextEditingController();
  final TextEditingController amuontPaidController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void clear() {
    expenseNameController.clear();
    amuontPaidController.clear();
    amountController.clear();
  }

  @override
  void initState() {
    if (widget.expense != null) {
      expenseNameController.text = widget.expense!.name;
      amuontPaidController.text = widget.expense!.amountPaid.toString();
      amountController.text = widget.expense!.amount.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categoriesList = ref.read(expenseCategoryListProvder);
    return SingleChildScrollView(
      child: Column(
        children: [
          buildCategory(context, categoriesList),
          const SizedBox(height: 20),
          Column(
            children: [
              buildProductName(),
              const SizedBox(height: 20),
              buildDueAmount(),
              const SizedBox(height: 20),
              buildDate(),
              const SizedBox(height: 20),
              buildPaidAmount(),
              const SizedBox(height: 20),
              buildDueDate(),
              const SizedBox(height: 20),
            ],
          ),
          buildSaveButton(ref, context),
        ],
      ),
    );
  }

  Row buildSaveButton(WidgetRef ref, BuildContext context) {
    return widget.expense != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: MThemeData.raisedButtonStyleSave,
                  child: Text(
                    'Update'.tr(),
                  ),
                  onPressed: () {
                    // var selectedShopClient = ref.watch(selectedShopClient);

                    if (expenseformKey.currentState!.validate()) {
                      // final ExpenseModel expense = ExpenseModel(
                      //   date: ref.watch(pickedDateTime.state).state,
                      //   id: widget.expense!.id,
                      //   name: expenseNameController.text.trim(),
                      //   amount: double.parse(amountController.text.trim()),
                      //   amountPaid:
                      //       double.parse(amuontPaidController.text.trim()),
                      //   deadLine: ref.watch(pickedDueDateTime.state).state,
                      //   expenseCategory: ref
                      //       .watch(selectedItemProvider.state)
                      //       .state
                      //       .toString()
                      //       .toExpenseCategory(),
                      // );
                      // ref
                      //     .read(databaseProvider)!
                      //     .updateExpense(expense)
                      //     .then((value) {
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: MThemeData.raisedButtonStyleSave,
                  child: Text(
                    'Save'.tr(),
                  ),
                  onPressed: () {
                    if (expenseformKey.currentState!.validate() &&
                        expenseformKey2.currentState!.validate()) {
                      //   final expense = ExpenseModel(
                      //     amount:
                      //         double.tryParse(amountController.text.trim()) ?? 0,
                      //     amountPaid:
                      //         double.tryParse(amuontPaidController.text.trim()) ??
                      //             0,
                      //     deadLine: ref.watch(pickedDueDateTime.state).state,
                      //     name: expenseNameController.text.trim(),
                      //     date: ref.read(pickedDateTime.state).state,
                      //     expenseCategory: ref
                      //         .read(selectedItemProvider.state)
                      //         .state!
                      //         .toExpenseCategory(),
                      //   );

                      //   ref
                      //       .read(databaseProvider)!
                      //       .addExpense(expense)
                      //       .then((value) {
                      //     if (value) {
                      //       ScaffoldMessenger.of(context)
                      //           .showSnackBar(MDialogs.snackBar('Done !'));
                      //       clear();
                      //       Navigator.of(context).pop();
                      //     } else {
                      //       ScaffoldMessenger.of(context)
                      //           .showSnackBar(MDialogs.errorSnackBar('Error !'));
                      //     }
                      //   });
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

  TextFormField buildPaidAmount() {
    return TextFormField(
      controller: amuontPaidController,
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

  Widget buildDueDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8,
          ),
          child: Text(
            'Due-Date'.tr(),
            style: Theme.of(context).textTheme.subtitle2!,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).bottomAppBarColor),
              borderRadius: BorderRadius.circular(6)),
          height: 50,
          width: 240,
          child: const SelectDueDate(),
        ),
      ],
    );
  }

  Widget buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8,
          ),
          child: Text(
            'Date'.tr(),
            style: Theme.of(context).textTheme.subtitle2!,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4, right: 4),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).bottomAppBarColor),
              borderRadius: BorderRadius.circular(6)),
          height: 50,
          width: 240,
          child: const SelectDate(),
        ),
      ],
    );
  }

  Form buildDueAmount() {
    return Form(
      key: expenseformKey,
      child: TextFormField(
        controller: amountController,
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
        decoration: InputDecoration(
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
      ),
    );
  }

  Form buildProductName() {
    return Form(
      key: expenseformKey2,
      child: TextFormField(
        controller: expenseNameController,
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "error".tr();
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Expense-Name'.tr(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: 'expense name',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          prefixIcon: const Icon(Icons.shopping_bag_outlined),
          filled: true,
        ),
      ),
    );
  }

  Widget buildCategory(BuildContext context, List<String> list) {
    return SpinnerWidget(
      list: list,
      hint: 'type of expense'.tr(),
    );
  }
}
