import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';
import 'package:hanouty/utils/constents.dart';
import 'package:flutter/material.dart';

import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../price_number_zone.dart';

class LatestTransactionsListCard extends ConsumerWidget {
  const LatestTransactionsListCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<FullSalesBloc, FullSalesState>(
      builder: (context, state) {
        return BluredContainer(
          height: 400,
          width: 420,
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
                    const Icon(Icons.more_vert),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state
                      .fullSales.length, // latestTransactionProduct.length,

                  itemBuilder: (BuildContext context, int index) {
                    //  final LatestTransactionModel latestTransactionModel = <LatestTransactionModel> [];
                    //_latestTransactionProduct[index];
                    state.fullSales
                        .sort((b, a) => a.dateSold.compareTo(b.dateSold));
                    final sale = state.fullSales[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: PriceNumberZone(
                                withDollarSign: true,
                                // right: Padding(
                                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                                //   child: getIcon(
                                //     context,
                                //     priceSoldFor: sale.priceSoldFor,
                                //     priceOut: sale.priceOut,
                                //   ),
                                // ),
                                price: sale.priceSoldFor,
                              ),
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
      },
    );
  }
}
// get Icon acording to difference between price and priceSoldFor

Icon getIcon(BuildContext context,
    {required double priceSoldFor, required double priceOut}) {
  if (priceSoldFor >= priceOut) {
    return Icon(FontAwesomeIcons.arrowUp,
        size: 16, color: Colors.green.shade400);
  } else if (priceSoldFor < priceOut) {
    return Icon(FontAwesomeIcons.arrowDown,
        size: 16, color: Colors.red.shade300);
  } else {
    return Icon(FontAwesomeIcons.arrowDown,
        size: 16, color: Theme.of(context).colorScheme.onPrimary);
  }
}
