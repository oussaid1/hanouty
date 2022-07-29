import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: 8),
                    Text(
                      "Sales By Category",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 140,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(61, 255, 255, 255),
                    ),
                    child: Autocomplete<TaggedSales>(
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
                        text: taggedSales1!.tag,
                      ),
                      optionsViewBuilder: (BuildContext context,
                          AutocompleteOnSelected<TaggedSales> onSelected,
                          Iterable<TaggedSales> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 200, maxWidth: 200),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final TaggedSales option =
                                      options.elementAt(index);
                                  return InkWell(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: Builder(
                                        builder: (BuildContext context) {
                                      final bool highlight =
                                          AutocompleteHighlightedOption.of(
                                                  context) ==
                                              index;
                                      if (highlight) {
                                        SchedulerBinding.instance
                                            .addPostFrameCallback(
                                                (Duration timeStamp) {
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
                                          RawAutocomplete
                                              .defaultStringForOption(
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
                        return TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(6.0),
                            //   borderSide: BorderSide(
                            //     width: 0.2,
                            //       color: AppConstants.whiteOpacity),
                            // ),
                            border: InputBorder.none,
                            //hintText: 'category_hint',
                            hintStyle: Theme.of(context).textTheme.subtitle2!,
                            filled: true,
                          ),
                          focusNode: focusNode,
                        );
                      },
                      onSelected: (TaggedSales selection) {
                        setState(() {
                          taggedSales1 = selection;
                        });
                        //log('Selected: $selection');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount Sold',
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity Sold',
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
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profit',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      PriceNumberZone(
                        price: taggedSales1?.salesData.totalNetProfit ?? 0,
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .headline4!
                        //     .copyWith(
                        //         color: Theme.of(context).colorScheme.primary),
                        withDollarSign: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
