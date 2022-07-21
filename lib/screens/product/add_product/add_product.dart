import 'dart:developer';

import 'package:hanouty/local_components.dart';
import 'package:flutter/services.dart';
import '../../../blocs/productbloc/product_bloc.dart';
import '../../../database/database_operations.dart';
import '../../../utils/constents.dart';
import '../../../widgets/date_pickers.dart/date_picker.dart';
import '../../../widgets/number_incrementer.dart';
import '/../components.dart';
import 'package:flutter/material.dart';

class AddProductFullPage extends StatelessWidget {
  const AddProductFullPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddOrEditProduct());
  }
}

class AddOrEditProduct extends StatefulWidget {
  final DateTime? initialDateTime;
  final num? initialValue;

  const AddOrEditProduct(
      {Key? key, this.product, this.initialDateTime, this.initialValue})
      : super(key: key);

  final ProductModel? product;
  @override
  AddOrEditProductState createState() => AddOrEditProductState();
}

class AddOrEditProductState extends State<AddOrEditProduct> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController barcodeController =
      TextEditingController(text: '123');
  final TextEditingController productNameController =
      TextEditingController(text: 'MacBook Pro');
  final TextEditingController priceInController =
      TextEditingController(text: '1000');
  final TextEditingController priceOutController =
      TextEditingController(text: '1200');
  final TextEditingController descrController =
      TextEditingController(text: 'This is a product description');
  String productCat = 'Other';
  String suplier = 'Other';
  DateTime _pickedDateTime = DateTime.now();
  num quantity = 1;
  bool canSave = false;

  /// this method clears all the controllers
  void clear() {
    barcodeController.clear();
    productNameController.clear();
    priceInController.clear();
    priceOutController.clear();
    descrController.clear();
  }

  void initializeFields() {
    if (widget.product != null) {
      barcodeController.text = widget.product!.barcode!;
      productNameController.text = widget.product!.productName;
      priceInController.text = widget.product!.priceIn.toString();
      priceOutController.text = widget.product!.priceOut.toString();
      descrController.text = widget.product!.description!;
      _pickedDateTime = widget.product!.dateIn;
      productCat = widget.product!.category!;
      suplier = widget.product!.suplier!;
      quantity = widget.product!.quantity;
    }
    if (widget.initialDateTime != null) {
      _pickedDateTime = widget.initialDateTime!;
    }
    if (widget.initialValue != null) {
      quantity = widget.initialValue!;
    }
  }

  @override
  void initState() {
    initializeFields();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
      child: SizedBox(
        width: 400,
        height: 800,
        child: Column(
          children: [
            //InStockWidget(dBProducts: dBProducts),
            buildFlexible(
              context,
              [],
            ),
          ],
        ),
      ),
    );
  }

  Flexible buildFlexible(BuildContext context, List<String> suplierList) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 2,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          width: Responsive.isDesktop(context) ? 600 : context.width - 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).dialogBackgroundColor,
            // gradient: MThemeData.gradient1,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                //buildBarcode(ref),
                //const SizedBox(height: 8),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _buildProductName(),
                      const SizedBox(height: 8),
                      _buildPriceIn(),
                      const SizedBox(height: 8),
                      _buildPriceOut(),
                      const SizedBox(height: 8),
                      _buildQuantity(context),
                      const SizedBox(height: 8),
                      _buildCategory(context, []),
                      const SizedBox(height: 8),
                      _buildDate(),
                      const SizedBox(height: 8),
                      _buildSuplier(suplierList),
                      const SizedBox(height: 8),
                      _buildDescription(),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),

                _buildSaveButton(context),
                const SizedBox(
                  height: 100,
                ) //but
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSaveButton(BuildContext context) {
    var prdBloc =
        ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return widget.product == null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: MThemeData.raisedButtonStyleSave,
                onPressed: !canSave
                    ? null
                    : () {
                        final product = ProductModel(
                          barcode: barcodeController.text.trim(),
                          dateIn: _pickedDateTime,
                          description: descrController.text.trim(),
                          category: productCat,
                          productName: productNameController.text.trim(),
                          priceIn:
                              double.tryParse(priceInController.text.trim())!,
                          priceOut:
                              double.tryParse(priceOutController.text.trim())!,
                          quantity: quantity.toInt(),
                          suplier: suplier,
                        );

                        if (formKey.currentState!.validate()) {
                          setState(() {
                            canSave = false;
                          });
                          prdBloc.add(AddProductEvent(product));
                        }
                      },
                child: Text(
                  'Save'.tr(),
                ),
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: MThemeData.raisedButtonStyleSave,
                child: Text(
                  'Update'.tr(),
                ),
                onPressed: () {
                  final product = ProductModel(
                    pId: widget.product!.pId,
                    barcode: barcodeController.text.trim(),
                    dateIn: _pickedDateTime,
                    description: descrController.text.trim(),
                    category: productCat,
                    productName: productNameController.text.trim(),
                    priceIn: double.tryParse(priceInController.text.trim())!,
                    priceOut: double.tryParse(priceOutController.text.trim())!,
                    quantity: quantity.toInt(),
                    suplier: suplier,
                  );

                  if (formKey.currentState!.validate()) {
                    setState(() {
                      canSave = false;
                    });
                    prdBloc.add(
                      UpdateProductEvent(product),
                    );
                  }
                },
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

  _buildDescription() {
    return TextFormField(
      controller: descrController,
      validator: (text) {
        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Description'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        //border: InputBorder.none,
        hintText: 'description_hint'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        filled: true,
      ),
    );
  }

  _buildCategory(BuildContext context, List<String> list) {
    return SizedBox(
      width: context.width,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return Category.categoriesStrings.where((String option) {
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
            onChanged: (text) {
              setState(() {
                productCat = text;
              });
            },
            decoration: InputDecoration(
              labelText: 'Category'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: AppConstants.whiteOpacity),
              ),
              //border: InputBorder.none,
              hintText: 'category_hint'.tr(),
              hintStyle: Theme.of(context).textTheme.subtitle2!,
              filled: true,
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
              log('You just typed a new entry  $value');
            },
          );
        },
        onSelected: (String selection) {
          setState(() {
            productCat = selection;
          });
          log('Selected: $selection');
        },
      ),
    );
  }

  _buildSuplier(List<String> list) {
    return SizedBox(
      width: 400,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return list.where((String option) {
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
                suplier = value;
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
              labelText: 'Suplier'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: AppConstants.whiteOpacity),
              ),
              //border: InputBorder.none,
              hintText: 'suplier'.tr(),
              // label: const Text('suplier').tr(),
              hintStyle: Theme.of(context).textTheme.subtitle2!,
              filled: true,
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
              log('You just typed a new entry  $value');
            },
          );
        },
        onSelected: (String selection) {
          setState(() {
            suplier = selection;
          });
          log('Selected: $selection');
        },
      ),
    );
  }

  _buildDate() {
    return SizedBox(
      width: 400,
      child: SelectDate(
        initialDate: widget.initialDateTime ?? DateTime.now(),
        onDateSelected: (date) {
          toast(
            'date: $date',
            context: context,
          );
          setState(() {
            _pickedDateTime = date;
          });
        },
      ),
    );
  }

  _buildQuantity(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: NumberIncrementerWidget(
        initialValue: quantity,
        onChanged: (num number) {
          setState(() {
            quantity = number;
          });
        },
      ),
    );
  }

  _buildPriceOut() {
    return TextFormField(
      controller: priceOutController,
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
        labelText: 'Price-out'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        hintText: '1434 dh',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on),
        filled: true,
      ),
    );
  }

  _buildPriceIn() {
    return TextFormField(
      controller: priceInController,
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
        labelText: 'Price-in'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        //border: InputBorder.none,
        hintText: '1234 \$',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: true,
      ),
    );
  }

  _buildProductName() {
    return TextFormField(
      controller: productNameController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      onChanged: (String value) {
        setState(() {
          canSave = value.isNotEmpty;
        });
      },
      decoration: InputDecoration(
        labelText: 'Product-Name'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        hintText: 'iphone-x LCD',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.tag),
        filled: true,
      ),
    );
  }

  // _buildBarcode() {
  //   return TextFormField(
  //     controller: barcodeController,
  //     validator: (text) {
  //       if (text!.trim().isEmpty) {
  //         return "error".tr();
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: 'Barcode'.tr(),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(6.0),
  //         borderSide: BorderSide(color: AppConstants.whiteOpacity),
  //       ),
  //       //  border: InputBorder.none,
  //       hintText: 'scan-barcode',
  //       hintStyle: Theme.of(context).textTheme.subtitle2!,
  //       contentPadding: const EdgeInsets.only(top: 4),
  //       prefixIcon: const Icon(Icons.qr_code_outlined),
  //       filled: true,
  //     ),
  //   );
  // }
}
