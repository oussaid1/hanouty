import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';
import 'package:hanouty/utils/constents.dart';
import 'package:flutter/material.dart';

import '../price_number_zone.dart';

class LatestTransactionsListCard extends ConsumerWidget {
  final List<SaleModel> salesList;
  const LatestTransactionsListCard({
    Key? key,
    required this.salesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BluredContainer(
      height: 300,
      width: 300,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.moneyCheck,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Recent Operations'.tr(),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: salesList.length, // latestTransactionProduct.length,

              itemBuilder: (BuildContext context, int index) {
                //  final LatestTransactionModel latestTransactionModel = <LatestTransactionModel> [];
                //_latestTransactionProduct[index];
                salesList.sort((b, a) => a.dateSold.compareTo(b.dateSold));
                final sale = salesList[index];
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: BluredContainer(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppConstants.whiteOpacity,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: sale.type == SaleType.product
                                  ? Icon(FontAwesomeIcons.cartShopping,
                                      size: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)
                                  : Icon(FontAwesomeIcons.toolbox,
                                      size: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  sale.productName,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                ),
                                Text(
                                  sale.dateSold.ddmmyyyy(),
                                  style: Theme.of(context).textTheme.subtitle2!,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PriceNumberZone(
                              withDollarSign: true,
                              right: Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: getIcon(
                                  context,
                                  priceSoldFor: sale.priceSoldFor,
                                  priceOut: sale.priceOut,
                                ),
                              ),
                              price: sale.priceSoldFor,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
// get Icon acording to difference between price and priceSoldFor

Icon getIcon(BuildContext context,
    {required double priceSoldFor, required double priceOut}) {
  if (priceSoldFor >= priceOut) {
    return Icon(FontAwesomeIcons.arrowUp,
        size: 16, color: Colors.green.shade300);
  } else if (priceSoldFor < priceOut) {
    return Icon(FontAwesomeIcons.arrowDown,
        size: 16, color: Colors.red.shade300);
  } else {
    return Icon(FontAwesomeIcons.arrowDown,
        size: 16, color: Theme.of(context).colorScheme.onPrimary);
  }
}
