import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import 'package:hanouty/models/product/product_calculations.dart';

import '../../blocs/productbloc/product_bloc.dart';
import '../../local_components.dart';
import '../../widgets/price_number_zone.dart';

class StockInventory extends StatelessWidget {
  const StockInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildOneItem(
            {required String label,
            required num value,
            bool withDollarsign = false}) =>
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      //color: MThemeData.productColor,
                    ),
              ),
            ),
            PriceNumberZone(
              withDollarSign: withDollarsign,
              right: const SizedBox.shrink(),
              price: value,
              priceStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        ProductCalculations productStockData = ProductCalculations(
          products: state.products,
        );
        return BluredContainer(
          width: 420,
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidPenToSquare,
                    ),
                    const SizedBox(width: 15),
                    Text('Stock',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 21),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildOneItem(
                        label: 'Price In',
                        value: productStockData.totalPriceInInStock,
                        withDollarsign: true,
                      ),
                      const SizedBox(width: 21),
                      buildOneItem(
                        label: 'Price Out',
                        value: productStockData.totalPriceOutInStock,
                        withDollarsign: true,
                      ),
                      const SizedBox(width: 21),
                      buildOneItem(
                        label: 'Items',
                        value: productStockData.productCountInStock,
                        withDollarsign: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Total Product Quantity".tr(),
                            style: Theme.of(context).textTheme.bodySmall),
                        PriceNumberZone(
                          withDollarSign: false,
                          right: const SizedBox.shrink(),
                          price: productStockData.totalProductQuantityInStock,
                          priceStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    //color: MThemeData.productColor,
                                  ),

                          // style: Theme.of(context)
                          //     .textTheme
                          //     .headline5!
                          //     .copyWith(color: context.theme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: context.theme.onPrimary,
                    endIndent: 8,
                    indent: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Capital',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: context.theme.onSecondaryContainer),
                        ),
                        PriceNumberZone(
                          right: const SizedBox.shrink(),
                          withDollarSign: true,
                          price: productStockData.totalCapitalInStock,
                          priceStyle: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: context.theme.onSecondaryContainer),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// Text("you have Products with zero quantity".tr(),
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle2!
//                                     .copyWith(
//                                         fontSize: 10,
//                                         color: const Color.fromARGB(
//                                             131, 255, 255, 255))),