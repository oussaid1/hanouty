import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';

import '../../widgets/price_number_zone.dart';

class OverallDebtsWidget extends StatelessWidget {
  final DebtData debtdata;
  const OverallDebtsWidget({
    Key? key,
    required this.debtdata,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      width: 420,
      height: 270,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.moneyBillTransfer),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Text(
                      'Overall'.tr(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              // IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.more_vert_outlined,
              //     ))
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  percent: debtdata.unitInterval,
                  progressColor: MThemeData.expensesColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 60,
                  child: Text(
                    '${debtdata.totalDifferencePercentage}%',
                    style: Theme.of(context).textTheme.headline3!.copyWith(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Highest'.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              //color: MThemeData.productColor,
                            ),
                      ),
                    ),
                    PriceNumberZone(
                      price: debtdata.highestDebtAmount,
                      withDollarSign: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Lowest'.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              //color: MThemeData.productColor,
                            ),
                      ),
                    ),
                    PriceNumberZone(
                      price: debtdata.lowestDebtAmount,
                      withDollarSign: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(
            height: 0,
            thickness: 1,
            color: Color.fromARGB(202, 255, 255, 255),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: context.theme.onSecondaryContainer),
                ),
                PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: debtdata.totalDebtAmount,
                    priceStyle: context.textTheme.headline1!.copyWith()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
