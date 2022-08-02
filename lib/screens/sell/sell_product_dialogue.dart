import 'package:hanouty/widgets/autocomplete/autocomlete_textfields.dart';
import 'package:hanouty/widgets/number_incrementer.dart';
import 'package:flutter/services.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../database/database_operations.dart';
import '../../local_components.dart';
import '../../widgets/date_pickers.dart/date_picker.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class SellProductDialoge extends StatefulWidget {
  const SellProductDialoge({
    Key? key,
    required this.product,
    // required this.clientNames,
    required this.saleType,
  }) : super(key: key);
  final ProductModel product;
  //final List<String> clientNames;
  final SaleType saleType;

  //final SaleModel? sale;
  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<SellProductDialoge> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // bool isProduct = true;
  int quantity = 1;
  //num qntLmt = 0;
  double priceSoldFor = 0;
  int rducedQnt = 0;
  String clientId = 'client';
  DateTime date = DateTime.now();
  bool _canSell = false, _isProduct = true;
  final TextEditingController priceCntlr = TextEditingController();
  void clear() {
    priceCntlr.clear();
  }

  initializeProperties() {
    // qntLmt = widget.product.quantity;
    _isProduct = widget.saleType == SaleType.product;
    priceSoldFor = widget.product.priceOut;
    priceCntlr.text = widget.product.priceOut.toString();
    rducedQnt = quantity = widget.product.quantity;
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Column(
              children: [
                _isProduct
                    ? Center(
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: widget.product.quantity == 0
                                ? Text('Product is out of stock',
                                    style:
                                        Theme.of(context).textTheme.bodyText1)
                                : Text(
                                    'Product quantity: ${widget.product.quantity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ))))
                    : const SizedBox.shrink(),
                buildClientName(),
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
      ),
    );
  }

  buildSaveButton(BuildContext context) {
    //PopupDialogs popups = ref.read(popupDialogs);
    var sellActionsBloc =
        SellActionsBloc(databaseOperations: GetIt.I<DatabaseOperations>());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: MThemeData.raisedButtonStyleSave,
          onPressed: !_canSell
              ? null
              : () {
                  //check the form is valid

                  if (formKey.currentState!.validate()) {
                    setState(() {
                      _canSell = false;
                    });
                    //save the product
                    SaleModel sale = SaleModel(
                      product: widget.product,
                      saleDescription: 'dummy Sale',
                      shopClientId: clientId,
                      priceSoldFor: double.parse(priceCntlr.text),
                      type: widget.saleType,
                      quantitySold: quantity,
                      dateSold: date,
                      productId: widget.product.pId!,
                    );

                    if (_isProduct) {
                      sellActionsBloc.add(
                        SellingRequestedEvent(
                          productModel: widget.product,
                          saleModel: sale,
                        ),
                      );
                    } else if (!_isProduct) {
                      sellActionsBloc.add(
                        SellServiceRequestedEvent(
                          saleModel: sale,
                        ),
                      );
                    }
                    clear();
                    Navigator.of(context).pop();
                    // setState(() {
                    //   qntLmt -= quantity;
                    // });
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
      limitUp: _isProduct ? widget.product.quantity : null,
      initialValue: quantity,
      labelText: 'Quantity'.tr(),
      fraction: 1,
      limitDown: 1,
      onChanged: (value) {
        setState(() {
          _canSell = true;
          quantity = value.toInt();
        });
      },
    );
  }

  buildPriceIn(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: priceCntlr,
        onChanged: (value) {
          setState(() {
            _canSell = true;
          });
        },
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

  buildClientName() {
    return ClientsAutocompleteWidget(
      onChanged: (value) {
        setState(() {
          _canSell = true;
          clientId = value.id!;
        });
      },
    );
  }
}
