import 'dart:developer';

import 'package:hanouty/widgets/autocomplete/autocomlete_textfields.dart';
import 'package:hanouty/widgets/number_incrementer.dart';
import 'package:flutter/services.dart';
import '../../../blocs/clientsbloc/clients_bloc.dart';
import '../../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../../database/database_operations.dart';
import '../../../local_components.dart';
import '../../../utils/constents.dart';
import '../../../widgets/date_pickers.dart/date_picker.dart';
import '../../../widgets/spinners/client_spinner.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class SellProductDialoge extends StatefulWidget {
  const SellProductDialoge({
    Key? key,
    required this.product,
    required this.clientNames,
    required this.pContext,
  }) : super(key: key);
  final ProductModel product;
  final List<String> clientNames;
  final BuildContext pContext;

  //final SaleModel? sale;
  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<SellProductDialoge> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // bool isProduct = true;
  int quantity = 1;
  double priceSoldFor = 0;
  int reducedProdutQuantity = 0;
  String clientId = 'client';
  DateTime date = DateTime.now();
  bool canSell = false;
  final TextEditingController priceOutController = TextEditingController();
  void clear() {
    priceOutController.clear();
  }

  initializeProperties() {
    priceSoldFor = widget.product.priceOut;
    priceOutController.text = widget.product.priceOut.toString();
    reducedProdutQuantity = quantity = widget.product.quantity;
  }

  @override
  void initState() {
    initializeProperties();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var clientsBloc = context.watch<ShopClientBloc>().state;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Column(
            children: [
              Center(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: widget.product.quantity == 0
                          ? Text('Product is out of stock',
                              style: Theme.of(context).textTheme.bodyText1)
                          : Text('Product quantity: ${widget.product.quantity}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  )))),
              buildClientName(widget.clientNames),
              const SizedBox(height: 15),
              buildQuantity(context),
              const SizedBox(height: 15),
              buildPriceIn(context),
              const SizedBox(height: 15),
              buildDate(),
              const SizedBox(height: 40),
            ],
          ),

          buildSaveButton(context),
          const SizedBox(
            height: 40,
          ) //but
        ],
      ),
    );
  }

  buildSaveButton(BuildContext context) {
    //PopupDialogs popups = ref.read(popupDialogs);
    var sellActionsBloc = SellActionsBloc(GetIt.I<DatabaseOperations>());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: MThemeData.raisedButtonStyleSave,
          onPressed: !canSell
              ? null
              : () {
                  //check the form is valid

                  if (formKey.currentState!.validate()) {
                    setState(() {
                      canSell = false;
                    });
                    //save the product
                    SaleModel sale = SaleModel(
                      product: widget.product,
                      saleDescription: 'dummy Sale',
                      shopClientId: clientId,
                      priceSoldFor: double.parse(priceOutController.text),
                      type: SaleType.product,
                      quantitySold: quantity,
                      dateSold: date,
                      productId: widget.product.pId!,
                    );

                    sellActionsBloc.add(
                      SellingRequested(
                        productModel: widget.product,
                        saleModel: sale,
                      ),
                    );
                  }
                },
          child: Text(
            'Sell'.tr(),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
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

  buildDate() {
    return SelectDate(
      initialDate: DateTime.now(),
      onDateSelected: (pickedDate) {
        setState(() {
          date = pickedDate;
        });
      },
    );
  }

  Widget buildQuantity(BuildContext context) {
    return NumberIncrementerWidget(
      limitUp: widget.product.quantity,
      initialValue: quantity,
      labelText: 'Quantity'.tr(),
      fraction: 1,
      limitDown: 1,
      onChanged: (value) {
        setState(() {
          quantity = value.toInt();
        });
      },
    );
  }

  buildPriceIn(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: priceOutController,
        onChanged: (value) {},
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
          labelText: 'Price'.tr(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: '1234 \$',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          prefixIcon: const Icon(Icons.monetization_on_outlined),
          filled: false,
        ),
      ),
    );
  }

  buildClientName(List<String> list) {
    log('buildClientName ${list.length}');
    return ClientsAutocompleteWidget(
      onChanged: (value) {
        setState(() {
          clientId = value.id!;
        });
      },
    );
  }
}
