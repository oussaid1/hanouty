import 'package:hanouty/models/product/product.dart';
import 'package:hanouty/providers/var_provider.dart';
import 'package:hanouty/utils/glasswidgets.dart';
import 'package:hanouty/screens/product/simple_products_list_card.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

import '../../blocs/productbloc/product_bloc.dart';

class ScaresProductslistCard extends ConsumerWidget {
  const ScaresProductslistCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final scaresValue = ref.watch(scareceValueProvider);
    // var productStock = ref.watch(productsStockDataStateNotifierProvider);
    // List<ProductModel> products =
    //     productStock.allProductsData.getProductsLessThan(scaresValue);
    return BluredContainer(
      height: 400,
      width: 300,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loaded) {
            var products = state.products;
            ProductStockData productStockData =
                ProductStockData(products: products);
            List<ProductModel> scaresProducts = productStockData
                .getProductsLessThan(ref.watch(scareceValueProvider));
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.list,
                              size: 18,
                            ),
                          ),
                          Text(
                            "Scares".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Numberincrementer(
                        value: ref.watch(scareceValueProvider),
                        onIncrement: () {
                          ref.read(scareceValueProvider.state).state++;
                        },
                        onDecrement: () {
                          ref.read(scareceValueProvider.state).state > 0
                              ? ref.read(scareceValueProvider.state).state--
                              : null;
                        },
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.more_vert,
                    //       color: MThemeData.hintTextColor,
                    //     ))
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: scaresProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      products.sort((a, b) => a.quantity.compareTo(b.quantity));
                      final ProductModel product = scaresProducts[index];
                      return SimpleProductListCard(
                        product: product,
                      );
                    },
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class Numberincrementer extends StatelessWidget {
  const Numberincrementer(
      {required this.value,
      required this.onIncrement,
      required this.onDecrement,
      Key? key})
      : super(key: key);
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              FontAwesomeIcons.minus,
              color: Theme.of(context).colorScheme.primary,
              size: 10,
            ),
            onPressed: () {
              onDecrement();
            }),
        Expanded(
            child: Text(
          value.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        )),
        IconButton(
            icon: const Icon(
              FontAwesomeIcons.plus,
              size: 10,
            ),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              onIncrement();

              //widget.onSaved(_number);
            }),
      ],
    );
  }
}
