import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';

import '../../blocs/debtbloc /debt_bloc.dart';
import '../../components.dart';
import '../../utils/constents.dart';
import '../../widgets/price_number_zone.dart';
import 'add_debt.dart';
import 'add_payment.dart';

class SimpleDebtCard extends StatelessWidget {
  const SimpleDebtCard({
    Key? key,
    required this.debt,
    this.client,
  }) : super(key: key);

  final DebtModel debt;
  final ShopClientModel? client;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                MDialogs.dialogSimple(
                  context,
                  title: Text(
                    "Pay".tr(),
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                  contentWidget: AddPayment(
                    payingStatus: PayingStatus.paying,
                    debt: debt,
                    client: client,
                  ),
                );
              },
              icon: Icons.payment,
              backgroundColor: MThemeData.accentColor,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                MDialogs.dialogSimple(
                  context,
                  title: Text(
                    "Edit".tr(),
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                  contentWidget: AddDebt(
                    debt: debt,
                  ),
                );
              },
              icon: Icons.edit,
              backgroundColor: MThemeData.secondaryColor,
            ),
            SlidableAction(
              onPressed: (context) {
                context.read<DebtBloc>().add(DeleteDebtEvent(debt));
              },
              icon: Icons.delete,
              backgroundColor: MThemeData.errorColor,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radius),
            color: const Color.fromARGB(54, 255, 255, 255),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 17,
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppConstants.radius),
                        bottomLeft: Radius.circular(AppConstants.radius),
                      ),
                      color: MThemeData.productColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    debt.timeStamp.ddmmyyyy(),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PriceNumberZone(
                  withDollarSign: true,
                  right: const SizedBox.shrink(), //const Text('left'),
                  price: debt.amount,
                  priceStyle: Theme.of(context).textTheme.headline4!.copyWith(
                        color: MThemeData.productColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
