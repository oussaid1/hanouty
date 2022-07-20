import 'package:flutter/material.dart';

class NumberIncrementerWidget extends StatefulWidget {
  final num fraction;
  final bool signed;
  final num? initialValue;
  final void Function(num) onChanged;
  final num? limit;

  const NumberIncrementerWidget({
    Key? key,
    required this.onChanged,
    this.initialValue,
    this.fraction = 1,
    this.signed = false,
    this.limit,
  }) : super(key: key);

  @override
  State<NumberIncrementerWidget> createState() =>
      _NumberIncrementerWidgetState();
}

class _NumberIncrementerWidgetState extends State<NumberIncrementerWidget> {
  late num number;
  @override
  void initState() {
    if (widget.initialValue != null) {
      setState(() {
        number = widget.initialValue!;
      });
    } else {
      number = 1;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).bottomAppBarColor),
          borderRadius: BorderRadius.circular(6)),
      height: 50,
      width: 140,
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              onPressed: () {
                if (widget.signed) {
                  setState(() {
                    number -= widget.fraction;
                    widget.onChanged(number);
                  });
                } else if (number > 0) {
                  setState(() {
                    number -= widget.fraction;
                    widget.onChanged(number);
                  });
                }
              }),
          Expanded(
              child: Text(
            number.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline3,
          )),
          IconButton(
              icon: const Icon(Icons.arrow_drop_up),
              color: Theme.of(context).colorScheme.primaryContainer,
              onPressed: () {
                if (widget.limit != null) {
                  setState(() {
                    while (number < widget.limit!) {
                      number += widget.fraction;
                      widget.onChanged(number);
                    }
                  });
                } else {
                  setState(() {
                    number += widget.fraction;
                  });
                  widget.onChanged(number);
                }
              }),
        ],
      ),
    );
  }
}
