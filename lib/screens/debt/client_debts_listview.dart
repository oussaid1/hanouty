import 'package:hanouty/screens/debt/add_debt.dart';
import 'package:hanouty/screens/debt/deb_list.dart';
import 'package:hanouty/widgets/search_widget.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../local_components.dart';
import '../../widgets/price_number_zone.dart';

class ClientDebtListView extends ConsumerWidget {
  const ClientDebtListView({Key? key, required this.debts}) : super(key: key);
  final List<ClientDebt> debts;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add debt",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 400,
                width: 400,
                child: AddDebt(),
              ),
            );
          },
          label: const Text("Add").tr(),
        ),
      ),
      body: SizedBox(
        height: 1000,
        width: 600,
        child: Column(
          children: [
            SearchByWidget(
              listOfCategories: const [],
              withCategory: false,
              onChanged: (value) {},
              onSearchTextChanged: (value) {},
              onBothChanged: (value, category) {},
            ),
            Expanded(
              child: ListView.builder(
                itemCount: debts.length,
                itemBuilder: (context, index) {
                  debts.sort((a, b) => b.totalLeft.compareTo(a.totalLeft));
                  final debt = debts[index];
                  return Card(
                    elevation: 0,
                    child: ExpansionTile(
                      leading: SizedBox(
                        width: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                              height: 50,
                              child: Card(
                                  color: debt.isFullyPaid
                                      ? MThemeData.serviceColor
                                      : MThemeData.productColor),
                            ),
                            const SizedBox(
                              width: 40,
                              child: Icon(
                                Icons.person_outline_sharp,
                                color: MThemeData.hintTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        '${debt.shopClient.clientName ?? "No name"} - ${debt.allDebts.length}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      trailing: Column(
                        children: [
                          PriceNumberZone(
                            withDollarSign: true,
                            right:
                                const SizedBox.shrink(), //const Text('left'),
                            price: debt.totalLeft,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: debt.isFullyPaid
                                          ? MThemeData.serviceColor
                                          : MThemeData.productColor,
                                    ),
                          ),
                          PriceNumberZone(
                            withDollarSign: true,
                            right:
                                const SizedBox.shrink(), //const Text('left'),
                            price: debt
                                .totalDebtAmount, // ==0? 0: debt.totalDebtAmount,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: debt.isFullyPaid
                                          ? MThemeData.serviceColor
                                          : MThemeData.productColor,
                                    ),
                          ),
                        ],
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text: ' Payments :'.tr(),
                          style: Theme.of(context).textTheme.subtitle2!,
                          children: [
                            TextSpan(
                              text: ' ${debt.totalPaidDebtAmount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: MThemeData.expensesColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: 400,
                          child: DebtList(debts: debt.allDebts),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
