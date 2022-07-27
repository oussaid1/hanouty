import 'package:flutter/material.dart';

import '../../models/debt/debt.dart';
import '../../widgets/price_number_zone.dart';
import 'simple_debtlistcard.dart';
import 'simple_payment_list_card.dart';

class DebtDetailsWidget extends StatelessWidget {
  const DebtDetailsWidget({
    Key? key,
    required this.clientDebt,
  }) : super(key: key);
  final ClientDebt? clientDebt;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: clientDebt != null
          ? Column(
              children: [
                /// title
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 5),
                          Text(clientDebt!.shopClient.clientName!,
                              style: Theme.of(context).textTheme.headline3),
                        ],
                      ),
                      PriceNumberZone(
                          withDollarSign: true,
                          right: const SizedBox.shrink(), //const Text('left'),
                          price: clientDebt!.debtData.totalDebtAmount,
                          signSize: 14,
                          priceStyle: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(108, 255, 255, 255),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      title: Text('Debts',
                          style: Theme.of(context).textTheme.headline3),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(clientDebt!.debtData.totalDebtAmount.toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      children: [
                        SizedBox(
                          height: 140,
                          width: 440,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                final debt = clientDebt!.allDebts[index];
                                return SimpleDebtCard(
                                  debt: debt,
                                );
                              },
                              itemCount: clientDebt!.allDebts.length),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(108, 255, 255, 255),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      title: Text('Payments',
                          style: Theme.of(context).textTheme.headline3),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(clientDebt!.debtData.totalPayments.toString(),
                              style: Theme.of(context).textTheme.bodySmall),
                          const Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      children: [
                        SizedBox(
                          height: 140,
                          width: 440,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                final payment = clientDebt!.allPayments[index];
                                return SimplePaymentListCard(
                                  payment: payment,
                                );
                              },
                              itemCount: clientDebt!.allPayments.length),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
