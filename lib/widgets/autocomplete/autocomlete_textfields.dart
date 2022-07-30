import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../blocs/suplierbloc/suplier_bloc.dart';
import '../../components.dart';
import '../../database/database_operations.dart';
import '../../models/client/shop_client.dart';
import '../../models/product/product.dart';
import '../../models/suplier/suplier.dart';
import '../../screens/client/add_client.dart';
import '../../utils/constents.dart';
import '../../utils/glasswidgets.dart';
import '../../utils/popup_dialogues.dart';

class ProductsAutoCompleteWidget extends StatelessWidget {
  final Function(ProductModel) onChanged;
  final ProductModel? initialValue;
  const ProductsAutoCompleteWidget({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>())
              ..add(GetProductsEvent()),
        child: ProductsAutocompleteField(
            onChanged: onChanged, initialValue: initialValue));
    //return ProductsAutocompleteField(onChanged: onChanged);
  }
}

class ProductsAutocompleteField extends StatelessWidget {
  final Function(ProductModel) onChanged;
  final ProductModel? initialValue;
  const ProductsAutocompleteField({
    Key? key,
    required this.onChanged,
    this.initialValue,
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
        if (state.products.isEmpty) {
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
          initialValue: TextEditingValue(text: initialValue?.productName ?? ''),
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<ProductModel> onSelected,
              Iterable<ProductModel> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 200, maxWidth: 200),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel option = options.elementAt(index);
                      return InkWell(
                        onTap: () {
                          onSelected(option);
                        },
                        child: Builder(builder: (BuildContext context) {
                          final bool highlight =
                              AutocompleteHighlightedOption.of(context) ==
                                  index;
                          if (highlight) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((Duration timeStamp) {
                              Scrollable.ensureVisible(context, alignment: 0.5);
                            });
                          }
                          return Container(
                            color:
                                highlight ? Theme.of(context).focusColor : null,
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              RawAutocomplete.defaultStringForOption(
                                  option.productName),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
            );
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

class ClientsAutocompleteWidget extends StatelessWidget {
  final Function(ShopClientModel) onChanged;
  final ShopClientModel? initialValue;
  const ClientsAutocompleteWidget({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopClientBloc(databaseOperations: GetIt.I<DatabaseOperations>())
            ..add(
              GetShopClientsEvent(),
            ),
      child: ClientAutocompleteInputField(
        onChanged: onChanged,
        initialValue: initialValue,
      ),
    );
    // return ClientAutocompleteInputField(onChanged: onChanged);
  }
}

class ClientAutocompleteInputField extends StatefulWidget {
  final Function(ShopClientModel) onChanged;
  //final String? Function(String?)? validator;
  final ShopClientModel? initialValue;
  const ClientAutocompleteInputField({
    Key? key,
    required this.onChanged,
    this.initialValue,
    // required this.validator,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;

  @override
  State<ClientAutocompleteInputField> createState() =>
      _ClientAutocompleteInputFieldState();
}

class _ClientAutocompleteInputFieldState
    extends State<ClientAutocompleteInputField> {
  ShopClientModel? client;
  @override
  void initState() {
    if (widget.initialValue != null) {
      client = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var list = <ShopClientModel>[];
    // list = [ShopClientModel.client, ...list];
    return BlocBuilder<ShopClientBloc, ShopClientState>(
      builder: (mcontext, state) {
        var list = [ShopClientModel.client, ...state.clients];

        if (state.status != ShopClientsStatus.loaded) {
          return Center(
            child: Text('no clients'.tr()),
          );
        }
        return Autocomplete<ShopClientModel>(
          displayStringForOption: ((option) {
            if (client != null) {
              return client!.clientName!;
            }
            return option.clientName!;
          }),
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
          initialValue: TextEditingValue(
            text: widget.initialValue?.clientName ?? '',
          ),
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<ShopClientModel> onSelected,
              Iterable<ShopClientModel> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 14.0,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 200, maxWidth: 200),
                  child: BluredContainer(
                    blurSygmaX: 93,
                    blurSygmaY: 93,
                    start: 0.2,
                    end: 0.1,
                    borderRadius: BorderRadius.circular(2),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final ShopClientModel option = options.elementAt(index);
                        return InkWell(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Builder(builder: (BuildContext context) {
                            final bool highlight =
                                AutocompleteHighlightedOption.of(context) ==
                                    index;
                            if (highlight) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((Duration timeStamp) {
                                Scrollable.ensureVisible(context,
                                    alignment: 0.5);
                              });
                            }
                            return Container(
                              // color: highlight ? Theme.of(context).focusColor : null,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: highlight
                                    ? Theme.of(context).focusColor
                                    : null,
                              ),
                              child: Text(
                                RawAutocomplete.defaultStringForOption(
                                    option.clientName),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
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
                            contentWidget: const AddClient(),
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

class SuplierAutocompleteWidget extends StatelessWidget {
  final Function(SuplierModel) onChanged;
  final SuplierModel? initialValue;
  const SuplierAutocompleteWidget(
      {Key? key, required this.onChanged, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SuplierBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
      child: SuplierAutocompleteField(
          onChanged: onChanged, initialSuplier: initialValue),
    );
  }
}

class SuplierAutocompleteField extends StatelessWidget {
  final Function(SuplierModel) onChanged;
  final SuplierModel? initialSuplier;
  const SuplierAutocompleteField({
    Key? key,
    required this.onChanged,
    this.initialSuplier,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(SuplierModel option) => option.name!;
  @override
  Widget build(BuildContext context) {
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
      initialValue: TextEditingValue(
        text: initialSuplier?.name ?? '',
      ),
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<SuplierModel> onSelected,
          Iterable<SuplierModel> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final SuplierModel option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          RawAutocomplete.defaultStringForOption(option.name),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
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
  final String? initialCategory;
  const CategoryAutocompleteField({
    Key? key,
    this.categories,
    required this.onChanged,
    this.initialCategory,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(String option) => option;
  @override
  Widget build(BuildContext context) {
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
      initialValue: TextEditingValue(
        text: initialCategory ?? '',
      ),
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          RawAutocomplete.defaultStringForOption(option),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
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
