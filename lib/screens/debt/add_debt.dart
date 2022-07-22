import 'package:hanouty/blocs/productbloc/product_bloc.dart';
import 'package:hanouty/local_components.dart';

import 'package:hanouty/widgets/date_pickers.dart/date_picker.dart';

import 'package:hanouty/widgets/select_or_add/select_or_add_cat.dart';
import 'package:flutter/services.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../utils/constents.dart';
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
  final TextEditingController paidAmountController = TextEditingController();
  String productName = "any";
  final TextEditingController dueAmountController = TextEditingController();
  DateTime date = DateTime.now();
  DateTime deadline = DateTime.now();
  String clientName = "client";
  bool _canSave = false;
  bool _isUpdate = false;

  /// clear the controller when the user clicks on the field
  void clear() {
    dueAmountController.clear();
  }

  /// initialize the controller with the debt's data
  void initialize() {
    super.initState();
    if (widget.debt != null) {
      _isUpdate = true;
      productName = widget.debt!.productName!;
      date = widget.debt!.timeStamp;
      deadline = widget.debt!.deadLine;
      dueAmountController.text = widget.debt!.amount.toString();
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
    var productsList = context.read<ProductBloc>().state;
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
                        buildClientName(),
                        const SizedBox(height: 10),
                        buildProductName(context, productsList.products),
                        const SizedBox(height: 10),
                        buildCategory([]),
                        const SizedBox(height: 10),
                        buildDueAmount(ref),
                        const SizedBox(height: 10),
                        buildDueDate(),
                        buildPaidAmount(ref),
                        const SizedBox(height: 10),
                        const SizedBox(height: 40),
                        buildSaveButton(context),
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

  buildSaveButton(BuildContext context) {
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
                        paidAmount: double.tryParse(paidAmountController.text)!,
                        clientId: widget.debt!.clientId,
                        productName: productName,
                        deadLine: deadline,
                        timeStamp: widget.debt!.timeStamp,
                        type: ref.read(selectedSelectOrAddCat.state).state,
                      );
                      GetIt.I<DebtBloc>().add(_isUpdate
                          ? UpdateDebtEvent(debt)
                          : AddDebtEvent(debt));
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
        labelText: 'Deadline Date'.tr(),
        initialDate: date,
        onDateSelected: (value) {
          setState(() {
            deadline = value;
          });
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

  buildProductName(BuildContext context, List<ProductModel> products) {
    return SizedBox(
      width: context.width,
      child: Autocomplete<ProductModel>(
        initialValue: TextEditingValue(text: productName),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<ProductModel>.empty();
          }
          return products.where((ProductModel option) {
            return option.productName
                .toString()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            onChanged: (text) {
              setState(() {
                _canSave = text.trim().isNotEmpty;
                productName = text.trim();
              });
            },
            decoration: InputDecoration(
              labelText: 'Product-Name'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: AppConstants.whiteOpacity),
              ),
              //border: InputBorder.none,
              hintText: 'product_name'.tr(),
              hintStyle: Theme.of(context).textTheme.subtitle2!,
              filled: true,
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
          );
        },
        onSelected: (ProductModel selection) {
          setState(() {
            productName = selection.productName;
          });
        },
      ),
    );
  }

  TextFormField buildPaidAmount(WidgetRef ref) {
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

  buildClientName() {
    return SizedBox(
      width: 400,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return <String>[].where((String option) {
            return option
                .toString()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            onChanged: (String value) {
              setState(() {
                clientName = value.trim();
              });
            },
            decoration: InputDecoration(
              prefixIcon: Tooltip(
                message: 'Add new suplier'.tr(),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    /// TODO: add new suplier Dialog
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AddSuplierPage(),
                    //   ),
                    // );
                  },
                ),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  textEditingController.clear();
                },
              ),
              labelText: 'Client'.tr(),
              border: OutlineInputBorder(
                /// TODO: globalize this
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                borderSide: BorderSide(color: AppConstants.whiteOpacity),
              ),
              //border: InputBorder.none,
              hintText: 'client'.tr(),
              // label: const Text('suplier').tr(),
              hintStyle: Theme.of(context).textTheme.subtitle2!,
              filled: true,
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
          );
        },
        onSelected: (String selection) {
          setState(() {
            clientName = selection;
          });
        },
      ),
    );
  }
}
