import 'package:hanouty/local_components.dart';

import 'package:hanouty/widgets/date_pickers.dart/date_picker.dart';

import 'package:hanouty/widgets/select_or_add/select_or_add_cat.dart';
import 'package:hanouty/widgets/spinners/client_spinner.dart';
import 'package:flutter/services.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class AddDebt extends ConsumerStatefulWidget {
  const AddDebt({Key? key, this.debt}) : super(key: key);
  final DebtModel? debt;
  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends ConsumerState<AddDebt> {
  final GlobalKey<FormState> dformKey = GlobalKey<FormState>();
  //final TextEditingController clientController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();

  final TextEditingController dueAmountController = TextEditingController();
  DateTime deadline = DateTime.now();
  void clear() {
    productNameController.clear();
    dueAmountController.clear();
  }

  @override
  void initState() {
    if (widget.debt != null) {
      productNameController.text = widget.debt!.productName!;
      deadline = widget.debt!.deadLine;
      dueAmountController.text = widget.debt!.amount.toString();
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
    // ignore: unused_local_variable
    // final dBProducts = ref.watch(productsProvider.state).state;

    // var clientNamesLis = ref.watch(shopClientsProvider.state).state;
    // var productCatList = ref.watch(productCategoryListProvider.state).state;
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
                        buildDate(),
                        const SizedBox(height: 10),
                        buildClientName(ref, []),
                        const SizedBox(height: 10),
                        buildProductName(ref),
                        const SizedBox(height: 10),
                        buildCategory([]),
                        const SizedBox(height: 10),
                        buildDueAmount(ref),
                        const SizedBox(height: 10),
                        buildDueDate(),

                        // buildPaidAmount(ref),
                        // const SizedBox(height: 20),

                        const SizedBox(height: 40),
                        buildSaveButton(
                          ref,
                          context,
                        ),
                        const SizedBox(
                          height: 20,
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

  Row buildSaveButton(WidgetRef ref, BuildContext context) {
    return widget.debt != null
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
                    if (dformKey.currentState!.validate()) {
                      final debt = DebtModel(
                        id: widget.debt!.id,
                        amount: double.tryParse(dueAmountController.text)!,
                        paid: 0,
                        clientName: widget.debt!.clientName,
                        clientId: widget.debt!.clientId,
                        productName: productNameController.text,
                        deadLine: deadline,
                        timeStamp: widget.debt!.timeStamp,
                        type: ref.read(selectedSelectOrAddCat.state).state,
                      );
                      GetIt.I<DebtBloc>().add(UpdateDebtEvent(debt));
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
                    if (dformKey.currentState!.validate()) {}
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

  Widget buildCategory(List<String> list) {
    return SelectOrAddNewDropDown(
      list: list,
      onSaved: (value) {},
      hintText: "Item-Type".tr(),
    );
  }

  Widget buildDueDate() {
    return SizedBox(
      height: 50,
      width: 240,
      child: SelectDate(
        initialDate: deadline,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        onDateSelected: (value) {
          deadline = value;
        },
      ),
    );
  }

  Widget buildDate() {
    return SizedBox(
      height: 50,
      width: 240,
      child: SelectDate(
        onDateSelected: (value) {
          deadline = value;
        },
      ),
    );
  }

  TextFormField buildDueAmount(WidgetRef ref) {
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
    );
  }

  TextFormField buildProductName(WidgetRef ref) {
    return TextFormField(
      controller: productNameController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Product-Name'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'product name',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.shopping_bag_outlined),
        filled: true,
      ),
    );
  }
  // TextFormField buildPaidAmount(WidgetRef ref) {
  //   return TextFormField(
  //     controller: amuontPaidController,
  //     validator: (text) {
  //       if (text!.trim().isEmpty) {
  //         return "error".tr();
  //       }
  //       return null;
  //     },
  //     keyboardType: const TextInputType.numberWithOptions(decimal: true),
  //     inputFormatters: [
  //       FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
  //     ],
  //     textAlign: TextAlign.center,
  //     decoration: InputDecoration(
  //       labelText: 'Amount-Paid'.tr(),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(6.0),
  //         borderSide: const BorderSide(),
  //       ),
  //       hintText: '1234 \$',
  //       hintStyle: Theme.of(context).textTheme.subtitle2!,
  //       contentPadding: const EdgeInsets.only(top: 4),
  //       prefixIcon: const Icon(Icons.monetization_on_outlined),
  //       filled: true,
  //     ),
  //   );
  // }

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
