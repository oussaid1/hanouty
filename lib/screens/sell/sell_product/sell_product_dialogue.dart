import 'dart:developer';

import 'package:hanouty/widgets/number_incrementer.dart';
import 'package:flutter/services.dart';
import '../../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../../database/database_operations.dart';
import '../../../local_components.dart';
import '../../../widgets/date_pickers.dart/date_picker.dart';
import '../../../widgets/spinners/client_spinner.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class SellProductDialoge extends StatefulWidget {
  const SellProductDialoge({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

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
  ShopClientModel client = ShopClientModel.client;
  DateTime date = DateTime.now();
  bool isSelling = false;
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
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          //color: Theme.of(context).colorScheme.onBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Column(
                children: [
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              widget.product.quantity == 0
                                  ? 'Product is out of stock'
                                  : 'Product quantity: ${widget.product.quantity}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  )))),
                  buildClientName([]),
                  const SizedBox(height: 8),
                  buildQuantity(context),
                  const SizedBox(height: 8),
                  buildPriceIn(context),
                  const SizedBox(height: 8),
                  buildDate(),
                  const SizedBox(height: 40),
                ],
              ),

              buildSaveButton(context),
              const SizedBox(
                height: 100,
              ) //but
            ],
          ),
        ),
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
          onPressed: !isSelling
              ? null
              : () {
                  //check the form is valid

                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isSelling = false;
                    });
                    //save the product
                    SaleModel sale = SaleModel(
                      shopClientId: client.id,
                      priceSoldFor: double.parse(priceOutController.text),
                      type: SaleType.product,
                      priceIn: widget.product.priceIn,
                      priceOut: widget.product.priceOut,
                      quantitySold: quantity,
                      dateSold: date,
                      productSoldName: widget.product.productName,
                      soldItemId: widget.product.id!,
                    );
                    log('Sale: $sale');
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
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
          border: Border.all(color: MThemeData.hintTextColor),
          borderRadius: BorderRadius.circular(6)),
      height: 50,
      width: 220,
      child: SelectDate(
        initialDate: DateTime.now(),
        onDateSelected: (pickedDate) {
          setState(() {
            date = pickedDate;
          });
        },
      ),
    );
  }

  Widget buildQuantity(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Quantity'.tr(),
            style: Theme.of(context).textTheme.bodyText1!,
          ),
          NumberIncrementerWidget(
            limitUp: widget.product.quantity,
            initialValue: quantity,
            onChanged: (value) {
              setState(() {
                quantity = value.toInt();
              });
            },
          ),
        ],
      ),
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

  Widget buildClientName(
    List<ShopClientModel> list,
  ) {
    return SizedBox(
      child: ClientSpinnerWidget(
        initialValue: client,
        onChanged: (value) {
          setState(() {
            client = value;
            isSelling = true;
          });
        },
        list: list..add(client),
      ),
    );
  }
}
