import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

import '../../models/debt/debt.dart';
import '../../utils/popup_dialogues.dart';
import '../../widgets/price_number_zone.dart';
import 'add_payment.dart';
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

                /// build actions
                /// pay button
                Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(108, 255, 255, 255),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MaterialButton(
                              elevation: 0,
                              onPressed: () {
                                MDialogs.dialogSimple(
                                  context,
                                  title: Text(
                                    "Pay".tr(),
                                    style:
                                        Theme.of(context).textTheme.headline3!,
                                  ),
                                  contentWidget: AddPayment(
                                    payingStatus: PayingStatus.adding,
                                    client: clientDebt!.shopClient,
                                  ),
                                );
                              },
                              color: const Color(0x5100C788),
                              child: Text(
                                "Pay".tr(),
                                style: Theme.of(context).textTheme.headline3!,
                              )),
                        ),
                      ],
                    ),
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
                          Text(clientDebt!.allDebts.length.toString(),
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
                                  client: clientDebt!.shopClient,
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
                          Text(clientDebt!.allPayments.length.toString(),
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
                                  client: clientDebt!.shopClient,
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
