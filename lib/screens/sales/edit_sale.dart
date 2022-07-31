import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';
import '../../models/models.dart';
import '../../widgets/autocomplete/autocomlete_textfields.dart';
import '../../widgets/date_pickers.dart/date_picker.dart';

class AddOrEditSaleWidget extends StatefulWidget {
  final SaleModel? sale;
  final ProductModel? product;
  final DateTime? initialDate;
  final int? initialQuantity;
  const AddOrEditSaleWidget({
    Key? key,
    this.sale,
    this.product,
    this.initialDate,
    this.initialQuantity,
  }) : super(key: key);

  @override
  UpdateSaleState createState() => UpdateSaleState();
}

class UpdateSaleState extends State<AddOrEditSaleWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  DateTime pickedDate = DateTime.now();
  ShopClientModel? client;
  bool isUpdating = false;
  bool canSave = false;

  var quantitySold = 1;

//////////////////////////////////////////////////////////////////////////////////////////////
  void clear() {
    priceController.clear();
  }

//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
  void initialize() {
    if (widget.sale != null) {
      isUpdating = true;
      priceController.text = widget.sale!.priceSoldFor.toString();
      pickedDate = widget.sale!.dateSold;
      quantitySold = widget.sale!.quantitySold;
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 15),
          buildClientName([]),
          const SizedBox(height: 15),
          Form(key: formKey, child: buildPrice(priceController)),
          const SizedBox(height: 15),
          buildDate(widget.initialDate ?? pickedDate),
          const SizedBox(height: 15),
          buildSaveButton(context),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  buildSaveButton(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          child: Text(
            'Cancel'.tr(),
            style: Theme.of(context).textTheme.bodyText1!,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          onPressed: !canSave
              ? null
              : () {
                  SaleModel sale = SaleModel(
                    saleId: isUpdating ? widget.sale!.saleId : null,
                    shopClientId: client!.id ?? widget.sale!.shopClientId,
                    priceSoldFor: double.parse(priceController.text),
                    type: widget.sale!.type,
                    quantitySold: quantitySold,
                    dateSold: pickedDate,
                    productId: widget.sale!.productId,
                  );
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      canSave = false;
                    });
                    if (isUpdating) {
                      GetIt.I.get<SalesBloc>().add(UpdateSalesEvent(sale));
                    } else {
                      GetIt.I.get<SalesBloc>().add(AddSalesEvent(sale));
                    }
                  }
                },
          child: Text(
            isUpdating ? 'Update'.tr() : 'Save'.tr(),
            style: Theme.of(context).textTheme.bodyText1!,
          ),
        ),
      ],
    );
  }

  buildDate(DateTime initialDate) {
    return SelectDate(
      initialDate: initialDate,
      onDateSelected: (mdate) {
        setState(() {
          pickedDate = mdate;
        });
      },
    );
  }

  TextFormField buildPrice(TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
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
    );
  }

  Widget buildClientName(
    List<ShopClientModel> list,
  ) {
    return SizedBox(
      child: ClientsAutocompleteWidget(
        onChanged: (value) {
          setState(() {
            canSave = true;
            client = value;
          });
        },
      ),
    );
  }
}
