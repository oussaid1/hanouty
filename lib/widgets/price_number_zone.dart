import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';
import 'package:flutter/material.dart';

class PriceNumberZone extends StatelessWidget {
  final TextAlign textAlign;
  final bool withDollarSign;
  final double price;
  final TextStyle? style;
  final Widget? right;
  const PriceNumberZone({
    Key? key,
    required this.price,
    required this.style,
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
            '${price.toPrecision()} '.tr(),
            textAlign: textAlign,
            style: style ??
                Theme.of(context)
                    .textTheme
                    .headline5!
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
