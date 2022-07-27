import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hanouty/screens/client/add_client.dart';

import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../components.dart';
import '../../models/client/shop_client.dart';
import '../../models/product/product.dart';
import '../../models/suplier/suplier.dart';
import '../../utils/constents.dart';
import '../../utils/popup_dialogues.dart';

class ProductsAutocompleteField extends StatelessWidget {
  final Function(ProductModel) onChanged;
  const ProductsAutocompleteField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(ProductModel option) =>
      option.productName;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        /// if there is no product in the list, show a progress indicator
        if (state.status != ProductStatus.loaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Autocomplete<ProductModel>(
          displayStringForOption: _displayStringForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<ProductModel>.empty();
            }
            return state.products.where((ProductModel option) {
              return option.productName
                  .toLowerCase()
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
              maxLength: 20,
              decoration: InputDecoration(
                counterText: '',
                labelText: 'Product'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide(color: AppConstants.whiteOpacity),
                ),
                //border: InputBorder.none,
                hintText: 'find product'.tr(),
                hintStyle: Theme.of(context).textTheme.subtitle2!,
                filled: true,
              ),
              focusNode: focusNode,
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
            );
          },
          onSelected: onChanged,
        );
      },
    );
  }
}

class ClientAutocompleteField extends StatefulWidget {
  final Function(ShopClientModel) onChanged;
  //final String? Function(String?)? validator;
  const ClientAutocompleteField({
    Key? key,
    required this.onChanged,
    // required this.validator,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(ShopClientModel option) =>
      option.clientName!;

  @override
  State<ClientAutocompleteField> createState() =>
      _ClientAutocompleteFieldState();
}

class _ClientAutocompleteFieldState extends State<ClientAutocompleteField> {
  ShopClientModel? client;
  @override
  Widget build(BuildContext context) {
    // var list = <ShopClientModel>[];
    // list = [ShopClientModel.client, ...list];
    return BlocBuilder<ShopClientBloc, ShopClientState>(
      builder: (context, state) {
        var list = [ShopClientModel.client, ...state.clients];
        log('_ClientAutocompleteFieldState ${list.length}');
        if (list.isEmpty) {
          return Center(
            child: Text('no clients'.tr()),
          );
        }
        return Autocomplete<ShopClientModel>(
          displayStringForOption:
              ClientAutocompleteField._displayStringForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const [];
            }
            return list.where((ShopClientModel option) {
              return option.clientName!
                  .toLowerCase()
                  .toString()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            return TextFormField(
              onChanged: (value) {
                setState(() {
                  client = null;
                });
                // print(value);
              },
              controller: textEditingController,
              maxLength: 20,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                suffixIcon: client != null
                    ? IconButton(
                        icon: const Icon(Icons.person_add_alt_1_outlined),
                        onPressed: () {
                          MDialogs.dialogSimple(
                            context,
                            title: Text(
                              'add client'.tr(),
                              style: Theme.of(context).textTheme.headline3!,
                            ),
                            contentWidget: SizedBox(
                              // height: 400,
                              width: 410,
                              child: SingleChildScrollView(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AddClient(pContext: context),
                                ],
                              )),
                            ),
                          );
                        },
                      )
                    : null,
                counterText: '',
                labelText: 'Client'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide(color: AppConstants.whiteOpacity),
                ),
                //border: InputBorder.none,
                hintText: 'find client'.tr(),
                hintStyle: Theme.of(context).textTheme.subtitle2!,
                filled: true,
              ),
              focusNode: focusNode,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (client == null) {
                  return 'Client is required'.tr();
                }
                return null;
              },
              onFieldSubmitted: (String value) {
                onFieldSubmitted();
              },
            );
          },
          onSelected: (option) {
            setState(() {
              client = option;
            });
            widget.onChanged(option);
          },
        );
      },
    );
  }
}

class SuplierAutocompleteField extends StatelessWidget {
  final Function(SuplierModel) onChanged;
  const SuplierAutocompleteField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(SuplierModel option) => option.name!;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc
    var list = <SuplierModel>[];
    return Autocomplete<SuplierModel>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<SuplierModel>.empty();
        }
        return list.where((SuplierModel option) {
          return option.name!
              .toLowerCase()
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
          maxLength: 20,
          decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.peopleLine),
            counterText: '',
            labelText: 'Suplier'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppConstants.whiteOpacity),
            ),
            //border: InputBorder.none,
            hintText: 'find suplier'.tr(),
            hintStyle: Theme.of(context).textTheme.subtitle2!,
            filled: true,
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: onChanged,
    );
  }
}

class CategoryAutocompleteField extends StatelessWidget {
  final Function(String) onChanged;
  final List<String>? categories;
  const CategoryAutocompleteField({
    Key? key,
    this.categories,
    required this.onChanged,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(String option) => option;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc
    var list = categories ?? ['Phone', 'Accessoir', 'Laptop', 'Tablet'];
    return Autocomplete<String>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return list.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.tag),
            counterText: '',
            labelText: 'Category'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppConstants.whiteOpacity),
            ),
            //border: InputBorder.none,
            hintText: 'find category'.tr(),
            hintStyle: Theme.of(context).textTheme.subtitle2!,
            filled: true,
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: onChanged,
    );
  }
}

// class ExpenseCategoryAutocompleteField extends StatelessWidget {
//   final Function(String) onChanged;

//   const ExpenseCategoryAutocompleteField({
//     Key? key,
//     required this.onChanged,
//   }) : super(key: key);

// //  static String _displayStringForOption(User option) => option.name;
//   static String _displayStringForOption(String option) => option;
//   @override
//   Widget build(BuildContext context) {
//     /// TODO: implement provide a list of products to autocomplete from ProductsBloc
//     var list = ExpenseCategory.values.map((e) => e.toString()).toList();
//     return Autocomplete<String>(
//       displayStringForOption: _displayStringForOption,
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return const Iterable<String>.empty();
//         }
//         return list.where((String option) {
//           return option
//               .toLowerCase()
//               .contains(textEditingValue.text.toLowerCase());
//         });
//       },
//       fieldViewBuilder: (BuildContext context,
//           TextEditingController textEditingController,
//           FocusNode focusNode,
//           VoidCallback onFieldSubmitted) {
//         return TextFormField(
//           controller: textEditingController,
//           maxLength: 20,
//           decoration: InputDecoration(
//             prefixIcon: const Icon(FontAwesomeIcons.tag),
//             counterText: '',
//             labelText: 'Category'.tr(),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6.0),
//               borderSide: BorderSide(color: AppConstants.whiteOpacity),
//             ),
//             //border: InputBorder.none,
//             hintText: 'find category'.tr(),
//             hintStyle: Theme.of(context).textTheme.subtitle2!,
//             filled: true,
//           ),
//           focusNode: focusNode,
//           onFieldSubmitted: (String value) {
//             onFieldSubmitted();
//           },
//         );
//       },
//       onSelected: onChanged,
//     );
//   }
// }
