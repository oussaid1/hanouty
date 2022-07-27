import 'package:flutter/material.dart';

import '../../models/payment/payment.dart';
import '../../settings/themes.dart';
import '../../utils/constents.dart';
import '../../widgets/price_number_zone.dart';

class SimplePaymentListCard extends StatelessWidget {
  const SimplePaymentListCard({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final PaymentModel payment;

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
    );
  }
}
