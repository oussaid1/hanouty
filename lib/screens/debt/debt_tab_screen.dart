import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';
import 'package:hanouty/models/payment/payment.dart';
import 'package:hanouty/screens/debt/add_payment.dart';
import 'package:hanouty/screens/debt/client_debts_listview.dart';
import 'package:hanouty/widgets/search_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/price_number_zone.dart';

class DebtTab extends ConsumerWidget {
  const DebtTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(),
            elevation: 0,
            flexibleSpace: Column(
              children: [
                TabBar(
                  indicatorColor: Theme.of(context).tabBarTheme.labelColor,
                  isScrollable: false,
                  tabs: [
                    Text(
                      'Debts'.tr(),
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                    Text(
                      'Payments'.tr(),
                      style: Theme.of(context).textTheme.subtitle2!,
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: const TabBarView(
            physics: BouncingScrollPhysics(),
            children: [ClientDebtListView(), PaymentsListView(payments: [])],
          )),
    );
  }
}

class PaymentsListView extends ConsumerWidget {
  const PaymentsListView({Key? key, required this.payments}) : super(key: key);
  final List<PaymentModel> payments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final db = ref.read(databaseProvider);
    //final allDebts = ref.watch(debtsListProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Payment".tr(),
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 410,
                width: 400,
                child: AddPayment(
                  payingStatus: PayingStatus.saving,
                ),
              ),
            );
            // for (var debt in allDebts.state) {
            //   db!.updateDebt(
            //     debt.copyWith(paid: 0),
            //   );
            //  db!.addPayment(
            //     Payment(
            //       clientName: debt.clientName,
            //       clientId: debt.clientId!,
            //       amount: debt.paid,
            //       date: debt.timeStamp,
            //       description: 'old',
            //     ),
            //   );
          },
          label: const Text("Add Payment").tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 800,
              width: 410,
              child: Column(
                children: [
                  SearchByWidget(
                    listOfCategories: const [],
                    onChanged: (value) {},
                    onSearchTextChanged: (value) {},
                    onBothChanged: (cat, text) {},
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        PaymentModel payment = payments[index];
                        return Card(
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: MThemeData.serviceColor,
                                  ),
                                  onPressed: () {
                                    MDialogs.dialogSimple(
                                      context,
                                      title: Text(
                                        "Add Payment".tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!,
                                      ),
                                      contentWidget: const SizedBox(
                                        height: 400,
                                        width: 400,
                                        child: AddPayment(
                                          payingStatus: PayingStatus.saving,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: MThemeData.errorColor,
                                  ),
                                  onPressed: () {
                                    MDialogs.dialogSimple(
                                      context,
                                      title: Text(
                                        " ${payment.clientName}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!,
                                      ),
                                      contentWidget: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: MThemeData
                                                .raisedButtonStyleSave,
                                            child: Text(
                                              'Delete'.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!,
                                            ),
                                            onPressed: () {},
                                          ),
                                          ElevatedButton(
                                            style: MThemeData
                                                .raisedButtonStyleCancel,
                                            child: Text(
                                              'Cancel'.tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.monetization_on,
                                  // color: MThemeData.accentColor,
                                  size: 30,
                                ),
                              ),
                              title: Text('${payment.clientName}',
                                  style:
                                      Theme.of(context).textTheme.subtitle2!),
                              trailing: PriceNumberZone(
                                withDollarSign: true,
                                right: const SizedBox.shrink(),
                                price: payment.amount,
                                // style: Theme.of(context)
                                //     .textTheme
                                //     .headline3!
                                //     .copyWith(
                                //         color: Theme.of(context)
                                //             .colorScheme
                                //             .primary),
                              ),
                              subtitle: Text(
                                payment.date.ddmmyyyy(),
                                style: Theme.of(context).textTheme.subtitle2!,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
