import 'package:flutter/material.dart';
import 'package:hanouty/screens/debt/add_payment.dart';

import '../../blocs/paymentsbloc/payments_bloc.dart';
import '../../components.dart';
import '../../models/client/shop_client.dart';
import '../../models/payment/payment.dart';
import '../../settings/themes.dart';
import '../../utils/constents.dart';
import '../../utils/popup_dialogues.dart';
import '../../widgets/price_number_zone.dart';

class SimplePaymentListCard extends StatelessWidget {
  const SimplePaymentListCard({
    Key? key,
    required this.payment,
    this.client,
  }) : super(key: key);

  final PaymentModel payment;
  final ShopClientModel? client;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radius),
          //   color: Theme.of(context).colorScheme.secondary,
          color: const Color.fromARGB(54, 255, 255, 255),
        ),
        child: Slidable(
          // startActionPane: ActionPane(
          //   motion: const ScrollMotion(),
          //   children: [
          //     SlidableAction(
          //       onPressed: (context) {
          //         MDialogs.dialogSimple(
          //           context,
          //           title: Text(
          //             "Pay".tr(),
          //             style: Theme.of(context).textTheme.headline3!,
          //           ),
          //           contentWidget: AddPayment(
          //             payingStatus: PayingStatus.paying,
          //             debt: debt,
          //             client: client,
          //           ),
          //         );
          //       },
          //       icon: Icons.payment,
          //       label: 'Pay',
          //       backgroundColor: MThemeData.accentColor,
          //     ),
          //   ],
          // ),
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
                    contentWidget: AddPayment(
                      payment: payment,
                      payingStatus: PayingStatus.editing,
                    ),
                  );
                },
                icon: Icons.edit,
                backgroundColor: MThemeData.secondaryColor,
              ),
              SlidableAction(
                onPressed: (context) {
                  context.read<PaymentsBloc>().add(DeletePaymentEvent(payment));

                  // MDialogs.dialogSimple(
                  //   context,
                  //   title: Text(
                  //     "Are you sure to delete this payment".tr(),
                  //     style: Theme.of(context).textTheme.headline3!,
                  //   ),
                  //   contentWidget: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       ElevatedButton(
                  //         style: MThemeData.raisedButtonStyleSave,
                  //         child: Text(
                  //           'Delete'.tr(),
                  //           style: Theme.of(context).textTheme.bodyText1!,
                  //         ),
                  //         onPressed: () {
                  //           context
                  //               .read<PaymentsBloc>()
                  //               .add(DeletePaymentEvent(payment));
                  //           Navigator.pop(context);
                  //         },
                  //       ),
                  //       ElevatedButton(
                  //         style: MThemeData.raisedButtonStyleCancel,
                  //         child: Text(
                  //           'Cancel'.tr(),
                  //           style: Theme.of(context).textTheme.bodyText1!,
                  //         ),
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
                icon: Icons.delete,
                backgroundColor: MThemeData.errorColor,
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            dense: true,
            leading: const VerticalDivider(
              width: 0,
              thickness: 8,
              indent: 0,
              color: MThemeData.serviceColor,
            ),
            title: Text(
              '${payment.clientName}',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PriceNumberZone(
                withDollarSign: true,
                right: const SizedBox.shrink(), //const Text('left'),
                price: payment.amount,
                priceStyle: Theme.of(context).textTheme.headline4!.copyWith(
                      color: MThemeData.serviceColor,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
