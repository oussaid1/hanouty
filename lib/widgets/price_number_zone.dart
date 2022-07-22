import 'package:flutter/material.dart';

import '../components.dart';

class PriceNumberZone extends StatelessWidget {
  final TextAlign textAlign;
  final bool withDollarSign;
  final num price;
  final TextStyle? priceStyle;
  final Widget? right;
  const PriceNumberZone({
    Key? key,
    required this.price,
    this.priceStyle,
    required this.withDollarSign,
    this.textAlign = TextAlign.end,
    this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$price',
            textAlign: textAlign,
            style: priceStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          withDollarSign
              ? Consumer(builder: (context, ref, _) {
                  const currency = '\$';
                  return Text(
                    currency.toString(),
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 8,
                        ),
                  );
                })
              : const SizedBox.shrink(),
          right ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
