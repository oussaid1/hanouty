import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/debt/debt.dart';
import '../../models/debt/debtsviewmodel.dart';
import 'simple_debtlistcard.dart';

class DueDebtsCard extends StatelessWidget {
  final DebtsStatsViewModel debtsStatsViewModel;
  const DueDebtsCard({
    Key? key,
    required this.debtsStatsViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DebtData debtData = DebtData(
        allDebts: debtsStatsViewModel.debts,
        allpayments: debtsStatsViewModel.payments);
    return SizedBox(
      height: 400,
      width: 420,
      child: Column(
        children: [
          SizedBox(
            width: 420,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.userClock),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18),
                      child: Text(
                        'Due Debts'.tr(),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert_outlined,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: debtData.overdueDebts.length,
              itemBuilder: (context, index) {
                final debt = debtData.overdueDebts[index];
                return SimpleDebtCard(
                  debt: debt,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
