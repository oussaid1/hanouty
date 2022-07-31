import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hanouty/utils/constents.dart';

import '../../models/tagged.dart';
import '../../widgets/price_number_zone.dart';

class SalesByCategoryWidget extends StatefulWidget {
  final List<TaggedSales> taggedSales;

  const SalesByCategoryWidget({
    Key? key,
    required this.taggedSales,
  }) : super(key: key);

  @override
  State<SalesByCategoryWidget> createState() => _SalesByCategoryWidgetState();
}

class _SalesByCategoryWidgetState extends State<SalesByCategoryWidget> {
  TaggedSales? taggedSales1;
  @override
  void initState() {
    if (widget.taggedSales.isNotEmpty) {
      taggedSales1 = widget.taggedSales[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitleSearch(context),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildAmountSold(context),
                const SizedBox(height: 8),
                buildItemsSold(context),
                const SizedBox(height: 8),
                buildQntity(context),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          buildProft(context),
        ],
      ),
    );
  }

  buildProft(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Profit',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          PriceNumberZone(
            price: taggedSales1?.salesData.totalNetProfit ?? 4350,
            priceStyle: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Theme.of(context).colorScheme.primary),
            withDollarSign: true,
          ),
        ],
      ),
    );
  }

  buildQntity(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Qnt',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        PriceNumberZone(
          price: taggedSales1?.salesData.totalQuantitySold ?? 0434,
          priceStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Theme.of(context).colorScheme.onSecondary),
          withDollarSign: true,
        ),
      ],
    );
  }

  buildItemsSold(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Items',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        PriceNumberZone(
          price: taggedSales1?.salesData.totalQuantitySold ?? 0,
          // style: Theme.of(context)
          //     .textTheme
          //     .headline5!
          //     .copyWith(
          //         color:
          //             Theme.of(context).colorScheme.onPrimary),
          withDollarSign: true,
        ),
      ],
    );
  }

  buildAmountSold(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Amount',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        PriceNumberZone(
          price: taggedSales1?.salesData.totalSoldAmount ?? 0,
          // style: Theme.of(context)
          //     .textTheme
          //     .headline5!
          //     .copyWith(
          //         color:
          //             Theme.of(context).colorScheme.onPrimary),
          withDollarSign: true,
        ),
      ],
    );
  }

  buildTitleSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search),
              const SizedBox(width: 8),
              Text(
                "Sales By Category",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          Autocomplete<TaggedSales>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<TaggedSales>.empty();
              }
              return widget.taggedSales.where((TaggedSales option) {
                return option.tag
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            initialValue: TextEditingValue(
              text: taggedSales1?.tag ?? '',
            ),
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<TaggedSales> onSelected,
                Iterable<TaggedSales> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 200, maxWidth: 200),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final TaggedSales option = options.elementAt(index);
                        return InkWell(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Builder(builder: (BuildContext context) {
                            final bool highlight =
                                AutocompleteHighlightedOption.of(context) ==
                                    index;
                            if (highlight) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((Duration timeStamp) {
                                Scrollable.ensureVisible(context,
                                    alignment: 0.5);
                              });
                            }
                            return Container(
                              color: highlight
                                  ? Theme.of(context).focusColor
                                  : null,
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                RawAutocomplete.defaultStringForOption(
                                    option.tag),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              return SizedBox(
                width: 140,
                height: 40,
                child: TextFormField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          width: 0.5, color: AppConstants.whiteOpacity),
                    ),
                    // labelText: 'Category',

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppConstants.whiteOpacity),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          width: 0.1, color: AppConstants.whiteOpacity),
                    ),
                    // border: InputBorder.none,
                    //hintText: 'category_hint',
                    hintStyle: Theme.of(context).textTheme.subtitle2!,
                    filled: true,
                  ),
                  focusNode: focusNode,
                ),
              );
            },
            onSelected: (TaggedSales selection) {
              setState(() {
                taggedSales1 = selection;
              });
              //log('Selected: $selection');
            },
          ),
        ],
      ),
    );
  }
}
