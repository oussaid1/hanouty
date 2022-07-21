import 'package:hanouty/local_components.dart';
import 'package:hanouty/models/payment/payment.dart';
import 'package:hanouty/screens/debt/add_debt.dart';
import 'package:hanouty/screens/debt/add_payment.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../widgets/price_number_zone.dart';

class DebtList extends ConsumerWidget {
  const DebtList({Key? key, required this.debts}) : super(key: key);
  final List<DebtModel> debts;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        height: 300,
        width: 600,
        child: ListView.builder(
          itemCount: debts.length,
          itemBuilder: (context, index) {
            final debt = debts[index];
            return Card(
              elevation: 0,
              child: Slidable(
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        MDialogs.dialogSimple(
                          context,
                          title: Text(
                            "Pay",
                            style: Theme.of(context).textTheme.headline3!,
                          ),
                          contentWidget: SizedBox(
                            height: 400,
                            width: 400,
                            child: AddPayment(
                              payingStatus: PayingStatus.paying,
                              payment: PaymentModel(
                                amount: debt.amount,
                                date: debt.timeStamp,
                                clientId: debt.clientId!,
                                clientName: debt.clientName,
                                description: '',
                              ),
                            ),
                          ),
                        );
                      },
                      label: ("Pay").tr(),
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(onPressed: (context) {
                      MDialogs.dialogSimple(
                        context,
                        title: Text(
                          "Add Client",
                          style: Theme.of(context).textTheme.headline3!,
                        ),
                        contentWidget: SizedBox(
                          height: 500,
                          width: 400,
                          child: AddDebt(
                            debt: debt,
                          ),
                        ),
                      );
                    }),
                    IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        size: 30,
                        color: Theme.of(context).errorColor,
                      ),
                      color: Colors.transparent,
                      onPressed: () {
                        MDialogs.dialogSimple(context,
                            title: const Text('Are you sure !!?').tr(),
                            widgets: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        minimumSize: const Size(88, 36),
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: MThemeData.accentColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                      ),
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: TextButton(
                                      onPressed: () {
                                        // ref
                                        //     .read(databaseProvider)!
                                        //     .deleteDebt(debt)
                                        //     .then((value) {
                                        //   if (value) {
                                        //     ScaffoldMessenger.of(context)
                                        //         .showSnackBar(MDialogs.snackBar(
                                        //             'Done !'));

                                        //     Navigator.of(context).pop();
                                        //   } else {
                                        //     ScaffoldMessenger.of(context)
                                        //         .showSnackBar(
                                        //             MDialogs.errorSnackBar(
                                        //                 'Error !'));
                                        //   }
                                        // });
                                      },
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        minimumSize: const Size(88, 36),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        elevation: 0,
                                        // disabledForegroundColor:
                                        //     Theme.of(context)
                                        //         .colorScheme
                                        //         .primary,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: MThemeData.accentColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                        ),
                                      ),
                                      child: Text(
                                        'Ok',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]);
                      },
                    ),
                  ],
                ),
                child: ExpansionTile(
                  leading: const SizedBox(
                    width: 50,
                    child: SizedBox(
                      width: 40,
                      child: Icon(
                        Icons.person_outline_sharp,
                        color: MThemeData.hintTextColor,
                      ),
                    ),
                  ),
                  title: Text(
                    '${debt.clientName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  trailing: PriceNumberZone(
                    withDollarSign: true,
                    right: const SizedBox.shrink(), //const Text('left'),
                    price: debt.amount,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: MThemeData.serviceColor,
                        ),
                  ),
                  subtitle: Text(
                    debt.deadLine.ddmmyyyy(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: MThemeData.productColor),
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Days :'.tr(),
                                style: Theme.of(context).textTheme.subtitle2!,
                                children: [
                                  TextSpan(
                                    text: ' ${debt.daysOverdue}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: MThemeData.serviceColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Since :'.tr(),
                                style: Theme.of(context).textTheme.subtitle2!,
                                children: [
                                  TextSpan(
                                    text: ' ${debt.timeStamp.ddmmyyyy()}',
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
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: ' Amount :'.tr(),
                                style: Theme.of(context).textTheme.subtitle2!,
                                children: [
                                  TextSpan(
                                    text: ' ${debt.amount}',
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
                            RichText(
                              text: TextSpan(
                                text: 'Product :'.tr(),
                                style: Theme.of(context).textTheme.subtitle2!,
                                children: [
                                  TextSpan(
                                      text: '${debt.type}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
